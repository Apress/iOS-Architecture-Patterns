//
//  TaskListViewController.swift
//  MVC-MyToDos
//
//  Created by Raúl Ferrer on 2/4/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private var taskListView = TaskListView()
    private var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private var tasksListService: TasksListServiceProtocol!

    init(tasksListModel: TasksListModel,
         taskService: TaskServiceProtocol,
         tasksListService: TasksListServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.tasksListService = tasksListService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        setupTaskListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
        taskListView.setTasksList(tasksListModel)
    }

    
    private func setupTaskListView() {
        taskListView.delegate = self
        self.view = taskListView
    }
    
    
    private func updateTasksList() {
        guard let list = tasksListService.fetchListWithId(tasksListModel.id) else { return }
        tasksListModel = list
        taskListView.setTasksList(tasksListModel)
    }
    
    @objc func contextObjectsDidChange() {
        updateTasksList()
    }
}


extension TaskListViewController: TaskListViewDelegate {
    
    func addTaskAction() {
        let addTaskViewController = AddTaskViewController(tasksListModel: tasksListModel, taskService: taskService)
        addTaskViewController.modalPresentationStyle = .pageSheet
        present(addTaskViewController, animated: true)
    }
    
    func updateTask(_ task: TaskModel) {
        taskService.updateTask(task)
    }
    
    func deleteTask(_ task: TaskModel) {
        taskService.deleteTask(task)
    }
}


extension TaskListViewController: BackButtonDelegate {
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
