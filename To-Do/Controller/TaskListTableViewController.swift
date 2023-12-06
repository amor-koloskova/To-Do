//
//  TaskListTableViewController.swift
//  To-Do
//
//  Created by Amor on 28.11.2023.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    // MARK: - Dependences
    
    // Хранилище задач
    var tasksStorage: TasksStorageProtocol = TasksStorage()
    
    // MARK: - Internal properties
    
    // Коллекция задач
    var tasks: [TaskPriority:[TaskProtocol]] = [:] {
        didSet {
            for (tasksGroupPriority, tasksGroup) in tasks { tasks[tasksGroupPriority] = tasksGroup.sorted{ task1, task2 in
                let task1position = tasksStatusPosition.firstIndex(of: task1.status) ?? 0
                let task2position = tasksStatusPosition.firstIndex(of: task2.status) ?? 0
                return task1position < task2position }
                
                //сохранение задач
                var savingArray: [TaskProtocol] = []
                tasks.forEach { _, value in
                    savingArray += value
                }
                tasksStorage.saveTasks(savingArray)
            }
        }
    }
    // Порядок отображения секций по типам
    // индекс в массиве соответствует индексу секции в таблице
    var sectionsTypesPosition: [TaskPriority] = [.important, .normal]
    var tasksStatusPosition: [TaskStatus] = [.planned, .completed]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // кнопка активации режима редактирования
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tasksTasks: Array = Array(tasks.values)
        navigationItem.leftBarButtonItem = editButtonItem
        if tasksTasks[0].isEmpty && tasksTasks[1].isEmpty {
            navigationItem.leftBarButtonItem!.isHidden = true
        } else {
            navigationItem.leftBarButtonItem?.isHidden = false
        }
    }
    
    // MARK: - Internal  Methods
    
    func setTasks(_ tasksCollection: [TaskProtocol]) {
        //подготовка коллекции с задачами
        // будем использовать только те задачи, для которых определена секция
        sectionsTypesPosition.forEach { taskType in
            tasks[taskType] = []
        }
        // загрузка и разбор задач из хранилища
        tasksCollection.forEach { task in
            tasks[task.priority]?.append(task)
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTasks() {
        // подготовка коллекции с задачами
        // будем использовать только те задачи, для которых определена секция в таблице
        sectionsTypesPosition.forEach { taskType in tasks[taskType] = []
        }
        // загрузка и разбор задач из хранилища
        tasksStorage.loadTasks().forEach { task in
            tasks[task.priority]?.append(task)
        }
    }
//    
//    // ячейка на основе ограничений
//    private func getConfiguredTaskCell_constraints(for indexPath: IndexPath) -> UITableViewCell {
//        // загружаем прототип ячейки по идентификатору
//        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstraints", for: indexPath)
//        // получаем данные о задаче, которую необходимо вывести в ячейке
//        let taskType = sectionsTypesPosition[indexPath.section]
//        guard let currentTask = tasks[taskType]?[indexPath.row] else {
//            return cell
//        }
//        // текстовая метка символа
//        let symbolLabel = cell.viewWithTag(1) as? UILabel
//        // текстовая метка названия задачи
//        let textLabel = cell.viewWithTag(2) as? UILabel
//        
//        // изменяем символ в ячейке
//        symbolLabel?.text = getSymbolForTask(with: currentTask.status)
//        // изменяем текст в ячейке
//        textLabel?.text = currentTask.title
//        // изменяем цвет текста и символа
//        if currentTask.status == .planned {
//            textLabel?.textColor = .black
//            symbolLabel?.textColor = .black
//        } else {
//            textLabel?.textColor = .lightGray
//            symbolLabel?.textColor = .lightGray
//        }
//        return cell
//    }
    
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCellTableViewCell
        // получаем данные о задаче, которые необходимо вывести в ячейке
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentType = tasks[taskType] else {
            return cell
        }
        if currentType.isEmpty {
            cell.title.text = "Задачи отсутствуют"
            cell.symbol.text = ""
            cell.title.textColor = .systemGray
            cell.symbol.textColor = .systemGray
        } else {
            guard let currentTask = tasks[taskType]?[indexPath.row] else {
                return cell
            }
            // изменяем текст в ячейке
            cell.title.text = currentTask.title
            // изменяем символ в ячейке
            cell.symbol.text = getSymbolForTask(with: currentTask.status)
            // изменяем цвет текста
            if currentTask.status == .planned {
                cell.title.textColor = .black
                cell.symbol.textColor = .black
            } else {
                cell.title.textColor = .lightGray
                cell.symbol.textColor = .lightGray
            }
        }
        return cell
    }
    
    // возвращаем символ для соответствующего типа задачи
    private func getSymbolForTask(with status: TaskStatus) -> String {
        var resultSymbol: String
        if status == .planned {
            resultSymbol = "\u{25CB}"
        } else if status == .completed {
            resultSymbol = "\u{25C9}"
        } else {
            resultSymbol = ""
        }
        return resultSymbol
    }
    
    // MARK: - Table View Data Source
    
    // Устанавливаем количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    //Устанавливаем количество строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // определяем приоритет задач, соответствующий текущей секции
        let taskPriority = sectionsTypesPosition[section]
        guard let currentTasksType = tasks[taskPriority] else {
            return 0
        }
        
        if currentTasksType.isEmpty {
                print("empty")
                print(currentTasksType)
                return 1
        } else {
            print("not empty")
            print(currentTasksType)
            return currentTasksType.count
        }
    }
    
    // Ячейка для строки таблицы
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return getConfiguredTaskCell_constraints(for: indexPath)
        return getConfiguredTaskCell_stack(for: indexPath)
    }
    
    // Устанавливаем заголовки для секций
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let tasksType = sectionsTypesPosition[section]
        if tasksType == .important {
            title = "Важные"
        } else if tasksType == .normal {
            title = "Текущие" }
        return title
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let taskType = sectionsTypesPosition[indexPath.section]
        var isRowEditing = true
        guard let currentType = tasks[taskType] else {
            return false
        }
        if currentType.isEmpty {
            isRowEditing = false
        }
        return isRowEditing
    }
    
    // Настройка действий при нажатии на строку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. Проверяем существование задачи
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentType = tasks[taskType] else {
            return
        }
        if currentType.isEmpty {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        } else {
            guard let _ = tasks[taskType]?[indexPath.row] else {
                return
            }
            // 2. Убеждаемся, что задача не является выполненной
            guard tasks[taskType]![indexPath.row].status == .planned else {
                // снимаем выделение со строки
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            // 3. Отмечаем задачу как выполненную
            tasks[taskType]![indexPath.row].status = .completed
            // 4. Перезагружаем секцию таблицы
            tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section),with: .automatic)
        }
    }
    
    // Настройка свайпа вправо
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // получаем данные о задаче, которую необходимо перевести в статус "запланирована"
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else {
            return nil
        }
        
        // создаем действие для изменения статуса
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Не выполнена") { _,_,_ in
            self.tasks[taskType]![indexPath.row].status = .planned
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
        // действие для перехода к экрану редактирования
        let actionEditInstance = UIContextualAction(style: .normal, title: "Изменить") { _, _, _ in
            //загрузка сцены со storyboard
            let editScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskEditController") as! TaskEditTableViewController
            // передача значений редактируемой задачи
            editScreen.taskText = self.tasks[taskType]![indexPath.row].title
            editScreen.taskPriority = self.tasks[taskType]![indexPath.row].priority
            editScreen.taskStatus = self.tasks[taskType]![indexPath.row].status
            
            // передача обработчика для сохранения задачи
            editScreen.doAfterEdit = { [ unowned self] title, priority, status in
                let editedTask = Task(title: title, priority: priority, status: status)
                tasks[taskType]!.remove(at: indexPath.row)
                tasks[editScreen.taskPriority]!.append(editedTask)
                tableView.reloadData()
            }
            //переход к экрану редактирования
            self.navigationController?.pushViewController(editScreen, animated: true)
        }
        // изменяем цвет фона кнопки с действием
        actionEditInstance.backgroundColor = .darkGray
        
        // создаем объект, описывающий доступные действия
        // в зависимости от статуса задачи будет отображено 1 или 2 действия
        let actionsConfiguration: UISwipeActionsConfiguration
        if tasks[taskType]![indexPath.row].status == .completed {
            actionsConfiguration = UISwipeActionsConfiguration(actions: [actionSwipeInstance, actionEditInstance])
        } else {
            actionsConfiguration = UISwipeActionsConfiguration(actions: [actionEditInstance])
        }
        return actionsConfiguration
    }
    
    // Удаление задач
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPosition[indexPath.section]
        // удаляем задачу
        tasks[taskType]?.remove(at: indexPath.row)
        // удаляем строку, соответствующую задаче
        //tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    // Ручная сортировка списка задач
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // секция, из которой происходит перемещение
        let taskTypeFrom = sectionsTypesPosition[sourceIndexPath.section]
        // секция, в которую происходит перемещение
        let taskTypeTo = sectionsTypesPosition[destinationIndexPath.section]
        // безопасно извлекаем задачу, тем самым копируем ее
        guard let movedTask = tasks[taskTypeFrom]?[sourceIndexPath.row] else {
            return
        }
        guard let toSection  = tasks[taskTypeTo] else {
            return
        }

        // удаляем задачу с места, откуда она перенесена
        tasks[taskTypeFrom]!.remove(at: sourceIndexPath.row)
                // вставляем задачу на новую позицию
        if toSection.isEmpty {
            tasks[taskTypeTo]!.insert(movedTask, at: 0)
            if taskTypeFrom != taskTypeTo {
                tasks[taskTypeTo]![0].priority = taskTypeTo
            }
        } else {
            tasks[taskTypeTo]!.insert(movedTask, at: destinationIndexPath.row)
            // если секция изменилась, изменяем тип задачи в соответствии с новой позицией
            if taskTypeFrom != taskTypeTo {
                tasks[taskTypeTo]![destinationIndexPath.row].priority = taskTypeTo
            }
        }
        // обновляем данные
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // Переход к экрану редактирования задачи
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateScreen" {
            let destination = segue.destination as! TaskEditTableViewController
            destination.doAfterEdit = { [ unowned self] title, priority, status in
                let newTask = Task(title: title, priority: priority, status: status)
                tasks[priority]?.append(newTask)
                tableView.reloadData()
            }
        }
    }
}
