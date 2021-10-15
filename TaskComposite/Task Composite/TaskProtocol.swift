//
//  TaskProtocol.swift
//  TaskComposite
//
//  Created by Margarita Novokhatskaia on 15/10/2021.
//

import Foundation

protocol TaskProtocol {
    var name: String { get }
    var subtask: [TaskProtocol] { get }
    func addSubtask(task: TaskProtocol)
}
