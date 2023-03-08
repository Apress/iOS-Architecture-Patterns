//
//  AddTaskViewController.swift
//  MVC-MyToDos
//
//  Created by Raúl Ferrer on 2/4/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    private var addTaskView = AddTaskView()
    private var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
        
    init(tasksListModel: TasksListModel,
         taskService: TaskServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.tasksListModel = tasksListModel
        self.taskService = taskService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupAddTaskView()
    }
    
    private func setupAddTaskView() {
        addTaskView.delegate = self
        self.view = addTaskView
    }
}

extension AddTaskViewController: AddTaskViewDelegate {
    
    func addTask(_ task: TaskModel) {
        taskService.saveTask(task, in: tasksListModel)
        dismiss(animated: true)
    }
}
