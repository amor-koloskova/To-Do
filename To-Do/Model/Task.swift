//
//  Task.swift
//  To-Do
//
//  Created by Amor on 28.11.2023.
//

import UIKit

enum TaskPriority {
    case normal
    case important
}

enum TaskStatus {
    case planned
    case completed
}

protocol TaskProtocol {
    var title: String { get set }
    var priority: TaskPriority { get set }
    var status: TaskStatus { get set }
}

struct Task: TaskProtocol {
    var title: String
    var priority: TaskPriority
    var status: TaskStatus
}
