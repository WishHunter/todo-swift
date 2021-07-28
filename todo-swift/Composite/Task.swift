//
//  Task.swift
//  todo-swift
//
//  Created by Denis Molkov on 28.07.2021.
//

import Foundation


class Task: TaskProtocol {
    var tasks: [TaskProtocol] = []
    let name: String
    let parent: TaskProtocol?
    
    init(name: String, parent: TaskProtocol?) {
        self.name = name
        self.parent = parent
    }
    
    func addTask(name: String) {
        tasks.append(Task(name: name, parent: self))
    }
}
