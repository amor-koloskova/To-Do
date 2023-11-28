//
//  TasksStorage.swift
//  To-Do
//
//  Created by Amor on 28.11.2023.
//

import UIKit

protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

class TasksStorage: TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
        let testTasks = [
            Task(title: "Купить хлеб", priority: .normal, status: .planned), Task(title: "Помыть кота", priority: .important, status: .planned), Task(title: "Отдать долг Арнольду", priority: .important, status:
            .completed),
            Task(title: "Купить новый пылесос", priority: .normal, status:
            .completed),
            Task(title: "Подарить цветы супруге", priority: .important, status:
            .planned),
            Task(title: "Позвонить родителям", priority: .important, status: .planned)
        ]
            return testTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {}
}
