//
//  ToDoModel.swift
//  ToDoUsingSupabase
//
//  Created by Rakan Alotaibi on 13/05/1445 AH.
//

import Foundation


struct ToDoModel: Identifiable, Codable {
    let id: Int?
    let title: String
    var isDone: Bool    
}
