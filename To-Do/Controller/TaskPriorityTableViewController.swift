//
//  TaskPriorityTableViewController.swift
//  To-Do
//
//  Created by Amor on 29.11.2023.
//

import UIKit

class TaskPriorityTableViewController: UITableViewController {
    // MARK: - Dependences
    
    var doAfterPrioritySelected: ((TaskPriority) -> Void)?
    
    // MARK: - Properties
    
    // 1. кортеж, описывающий тип задачи
    typealias PriorityCellDescription = (priority: TaskPriority, title: String, description: String)
    // 2. коллекция доступных типов задач с их описанием
    private var taskTypesInformation: [PriorityCellDescription] = [
        (priority: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным для выполнения. Все важные задачи выводятся в самом верху списка задач"),
        (priority: .normal, title: "Текущая", description: "Задача с обычным приоритетом") ]
    // 3. выбранный приоритет
    var selectedType: TaskPriority = .normal
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. получение значение типа UINib, соответствующее xib-файлу кастомной ячейки
        let cellPriorityNib = UINib(nibName: "TaskPriorityTableViewCell", bundle: nil)
        // 2. регистрация кастомной ячейки в табличном представлении
        tableView.register(cellPriorityNib, forCellReuseIdentifier: "TaskPriorityTableViewCell")
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskTypesInformation.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskPriorityTableViewCell", for: indexPath) as! TaskPriorityTableViewCell
        let priorityDescription = taskTypesInformation[indexPath.row]
        // 3. заполняем ячейку данными
        cell.priorityTitle.text = priorityDescription.title
        cell.priorityDescription.text = priorityDescription.description
        // 4. если тип является выбранным, то отмечаем галочкой
        if selectedType == priorityDescription.priority {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = taskTypesInformation[indexPath.row].priority
        doAfterPrioritySelected?(selectedType)
        navigationController?.popViewController(animated: true)
    }
}
