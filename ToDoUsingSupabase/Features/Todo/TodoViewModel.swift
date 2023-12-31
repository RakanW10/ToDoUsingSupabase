//
//  ContentViewModel.swift
//  ToDoUsingSupabase
//
//  Created by Rakan Alotaibi on 13/05/1445 AH.
//

import Foundation
import Supabase

class TodoViewModel: ObservableObject {
    @Published var todos: [ToDoModel] = []
    @Published var titleTextField = ""
    // NOTE: You need to write your supabaseURL & supabaseKey
    let supabase = SupabaseClient(supabaseURL:/* هنا لازم تكتب رابط الداتا بيس حقتك*/, supabaseKey: /* هنا لازم تكتب مفتاح الداتا بيس حقتك*/)

    // READ
    func fetchToDos() async {
        do {
            let postgrestResponse = try await supabase.database.from("Todos").select().execute()

            let decoder = JSONDecoder()

            let decodedData = try decoder.decode([ToDoModel].self, from: postgrestResponse.data)
            DispatchQueue.main.sync {
                todos = decodedData
            }
        } catch {
            print(error)
        }
    }

    // CREATE
    func addToDo() async {
        do {
            let tempToDo = ToDoModel(id: UUID(), title: titleTextField, isDone: false)
            // 1- add to local data
            DispatchQueue.main.sync {
                todos.append(tempToDo)
            }

            // 2- add to database
            try await supabase.database.from("Todos").insert(tempToDo).execute()
        } catch {
            print(error)
        }
    }

    // UPDATE
    func toggleTodo(index: Int) async {
        do {
            // 1- update local data
            DispatchQueue.main.sync {
                todos[index].isDone.toggle()
            }

            // 2- update database
            try await supabase.database.from("Todos").update(todos[index]).eq("id", value: todos[index].id).execute()

        } catch {
            print(error)
        }
    }

    // DELETE
    func deleteToDo(index: Int) async {
        do {
            var removedToDo: ToDoModel?
            // 1- delete from local data
            DispatchQueue.main.sync {
                removedToDo = todos.remove(at: index)
            }
            
            // 2- delte from database
            try await supabase.database.from("Todos").delete().eq("id", value: removedToDo!.id).execute()
        }catch{
            print(error)
        }
    }
}
