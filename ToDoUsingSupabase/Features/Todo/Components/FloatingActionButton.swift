//
//  FloatingActionButton.swift
//  ToDoUsingSupabase
//
//  Created by Rakan Alotaibi on 13/05/1445 AH.
//

import SwiftUI

struct FloatingActionButton: View {
    @Binding var isSheetPresented: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(
                    action: {
                        isSheetPresented.toggle()
                    },
                    label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32)
                            .padding()
                            .background(
                                Circle()
                                    .fill(.blue)
                            )
                            .tint(.white)
                    })
            }
        }
        .padding()
    }
}

#Preview {
    FloatingActionButton(isSheetPresented: .constant(true))
}
