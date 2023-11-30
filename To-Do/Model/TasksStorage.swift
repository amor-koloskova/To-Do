//
//  TasksStorage.swift
//  To-Do
//
//  Created by Amor on 28.11.2023.
//

import Foundation

protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

class TasksStorage: TasksStorageProtocol {
    // Ссылка на хранилище
    private var storage = UserDefaults.standard
    
    // Ключ, по которому будет происходит сохранение и загрузка хранилища из UserDefaults
    var storageKey: String = "tasks"
    
    //Перечисление с ключами для записи в UserDefaults
    
    private enum TaskKey: String {
        case title
        case priority
        case status
    }
    
    func loadTasks() -> [TaskProtocol] {
        var resultTasks: [TaskProtocol] = []
        let tasksFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for task in tasksFromStorage {
            guard let title = task[TaskKey.title.rawValue],
                  let priorityRaw = task[TaskKey.priority.rawValue],
                  let statusRaw = task[TaskKey.status.rawValue] else {
                continue
            }
            let priority: TaskPriority = (priorityRaw == "important") ? .important : .normal
            let status: TaskStatus = (statusRaw == "planned") ? .planned : .completed
            resultTasks.append(Task(title: title, priority: priority, status: status))
        }
        return resultTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String:String]] = []
        tasks.forEach { task in
            var newElementForStorage: Dictionary<String,String> = [:]
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.priority.rawValue] = (task.priority == .important) ? "important" : "normal"
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
