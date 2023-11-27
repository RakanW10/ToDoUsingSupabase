//
//  ContentView.swift
//  ToDoUsingSupabase
//
//  Created by Rakan Alotaibi on 13/05/1445 AH.
//

import SwiftUI
struct TodoView: View {
    @StateObject var vm = TodoViewModel()
    @State var isSheetPresented: Bool = false
    var body: some View {
        ZStack {
            if vm.todos.isEmpty {
                Text("No Data 😞")
            } else {
                List {
                    ForEach(vm.todos.indices, id: \.self) { index in
                        Text(vm.todos[index].title)
                            .strikethrough(vm.todos[index].isDone, color: .red)
                            .onTapGesture(
                                count: 2,
                                perform: {
                                    Task{
                                        await vm.toggleTodo(index: index)
                                    }
                                }
                            )
                            .swipeActions{
                                Button(role: .destructive){
                                    Task{
                                        await vm.deleteToDo(index: index)
                                    }
                                } label: {
                                    Text("Remove")
                                }

                            }
                    }
                }
            }
            FloatingActionButton(isSheetPresented: $isSheetPresented)
        }
        .sheet(
            isPresented: $isSheetPresented,
            content: {
                VStack {
                    TextField("Enter todo title", text: $vm.titleTextField)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray.opacity(0.2))
                        )
                    Button(
                        action: {
                            Task {
                                await vm.addToDo()
                            }
                            isSheetPresented.toggle()
                        },
                        label: {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                        })
                }
                .presentationDetents([.fraction(0.25)])
            }
        )

        .onAppear {
            Task {
                await vm.fetchToDos()
            }
        }
    }
}

#Preview {
    TodoView()
}
