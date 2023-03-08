//
//  AddTaskCoordinator.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 26/7/22.
//

import UIKit

protocol AddTaskCoordinatorProtocol {
    func dismiss()
}

class AddTaskCoordinator: Coordinator, AddTaskCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var tasksList: TasksListModel!

    init(navigationController: UINavigationController, tasksList: TasksListModel) {
        self.navigationController = navigationController
        self.tasksList = tasksList
    }
    
    func start() {
        let viewModel = AddTaskViewModel(tasksListModel: tasksList,
                                         taskService: TaskService(),
                                         coordinator: self)
        navigationController.present(AddTaskViewController(viewModel: viewModel), animated: true)
        
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
