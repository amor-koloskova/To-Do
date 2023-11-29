//
//  TaskEditTableViewController.swift
//  To-Do
//
//  Created by Amor on 29.11.2023.
//

import UIKit

class TaskEditTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // обновление текстового поля с названием задачи
        taskTitle?.text = taskText
        taskPriorityLabel?.text = taskTitles[taskPriority]
        // обновляем статус задачи
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
    }
    
    @IBOutlet var taskTitle: UITextField!
    @IBOutlet var taskPriorityLabel: UILabel!
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    var taskText: String = ""
    var taskPriority: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    private var taskTitles: [TaskPriority:String] = [.important: "Важная", .normal: "Текущая"]
    
    @IBAction func saveTasks(_ sender: UIBarButtonItem) {
        // получаем актуальные значения
        let title = taskTitle?.text ?? ""
        let priority = taskPriority
        let status: TaskStatus = taskStatusSwitch.isOn ?
            .completed : .planned
        doAfterEdit?(title, priority, status)
        navigationController?.popViewController(animated: true)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskPriorityScreen" {
            // ссылка на контроллер назначения
            let destination = segue.destination as! TaskPriorityTableViewController
            // передача выбранного типа
            destination.selectedType = taskPriority
            // передача обработчика выбора типа
            destination.doAfterPrioritySelected = { [unowned self] selectedType in
                taskPriority = selectedType
                // обновляем метку с текущим типом
                taskPriorityLabel?.text = taskTitles[taskPriority]
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
