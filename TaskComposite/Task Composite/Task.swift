//
//  Task.swift
//  TaskComposite
//
//  Created by Margarita Novokhatskaia on 15/10/2021.
//

import Foundation

final class Task: TaskProtocol {
    
    var name: String
    
    var subtask: [TaskProtocol]
    
    init(name: String, subtask: [TaskProtocol]) {
        self.name = name
        self.subtask = subtask
    }
    
    func addSubtask(task: TaskProtocol) {
        self.subtask.append(task)
    }
    
}
