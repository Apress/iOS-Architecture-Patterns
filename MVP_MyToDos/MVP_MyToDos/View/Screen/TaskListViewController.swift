//
//  TaskListViewController.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private var taskListView = TaskListView()
    private var tasksListModel: TasksListModel!

    init(tasksListModel: TasksListModel) {
        self.tasksListModel = tasksListModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupTaskListView()
    }
    
    private func setupTaskListView() {
        let presenter = TasksListPresenter(taskListView: taskListView,
                                           tasksListModel: tasksListModel,
                                           taskService: TaskService(),
                                           tasksListService: TasksListService())
        taskListView.delegate = self
        taskListView.presenter = presenter
        taskListView.setupView()
        self.view = taskListView
    }
}


extension TaskListViewController: TaskListViewControllerDelegate {
    
    func addTask() {
        let addTaskViewController = AddTaskViewController(tasksListModel: tasksListModel)
        addTaskViewController.modalPresentationStyle = .pageSheet
        present(addTaskViewController, animated: true)
    }
}


extension TaskListViewController: BackButtonDelegate {
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
