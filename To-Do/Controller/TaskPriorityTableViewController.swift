//
//  TaskPriorityTableViewController.swift
//  To-Do
//
//  Created by Amor on 29.11.2023.
//

import UIKit

class TaskPriorityTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. получение значение типа UINib, соответствующее xib-файлу кастомной ячейки
        let cellPriorityNib = UINib(nibName: "TaskPriorityTableViewCell", bundle: nil)
        // 2. регистрация кастомной ячейки в табличном представлении
        tableView.register(cellPriorityNib, forCellReuseIdentifier: "TaskPriorityTableViewCell")
    }
    
    var doAfterPrioritySelected: ((TaskPriority) -> Void)?
    
    // 1. кортеж, описывающий тип задачи
    typealias PriorityCellDescription = (priority: TaskPriority, title: String, description: String)
    // 2. коллекция доступных типов задач с их описанием
    private var taskTypesInformation: [PriorityCellDescription] = [
        (priority: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным для выполнения. Все важные задачи выводятся в самом верху списка задач"),
        (priority: .normal, title: "Текущая", description: "Задача с обычным приоритетом") ]
    // 3. выбранный приоритет
    var selectedType: TaskPriority = .normal

    // MARK: - Table view data source

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
