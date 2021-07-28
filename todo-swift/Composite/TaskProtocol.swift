//
//  TaskProtocol.swift
//  todo-swift
//
//  Created by Denis Molkov on 28.07.2021.
//

import Foundation

protocol TaskProtocol {
    var tasks: [TaskProtocol] { get set }
    var parent: TaskProtocol? { get }
    var name: String { get }
    func addTask(name: String)
}
