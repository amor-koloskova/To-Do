//
//  TaskEditTableViewController.swift
//  To-Do
//
//  Created by Amor on 29.11.2023.
//

import UIKit

class TaskEditTableViewController: UITableViewController {
    // MARK: - Dependendes
    
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    // MARK: - Internal Properties
    
    var taskText: String = ""
    var taskPriority: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    
    // MARK: - Private Properties
    
    private var taskTitles: [TaskPriority:String] = [.important: "Важная", .normal: "Текущая"]
    
    // MARK: - UI Elements
    
    @IBOutlet var taskTitle: UITextField! //{
//        didSet {
//            if taskTitle.text != "" {
//                return
//            } else {
//                let alert = UIAlertController(title: "Ошибка", message: "Задача должна иметь название", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Попробовать снова", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
    @IBOutlet var taskPriorityLabel: UILabel!
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    
    @IBAction func saveTasks(_ sender: UIBarButtonItem) {
        // получаем актуальные значения
        let title = taskTitle?.text ?? ""
        let priority = taskPriority
        let status: TaskStatus = taskStatusSwitch.isOn ?
            .completed : .planned
        // Убираем пробелы из названия
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        // Проверяем, есть ли название задачи
        if trimmedTitle == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Задача должна иметь название", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Попробовать снова", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            doAfterEdit?(trimmedTitle, priority, status)
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Life Cycle
    
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

    // MARK: - Table view data source
    
    // Устанавливаем количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Устанавливаем количество строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    // Снятие выделения со строки после нажатия
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        return
    }
    
    // MARK: - Navigation
    
    // Переход к экрану выбора приоритета задачи
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
}
