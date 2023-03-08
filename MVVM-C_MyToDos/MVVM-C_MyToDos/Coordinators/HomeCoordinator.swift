//
//  HomeCoordinator.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 26/7/22.
//

import UIKit

protocol HomeCoordinatorProtocol {
    func showSelectedList(_ list: TasksListModel)
    func gotoAddList()
}

class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(tasksListService: TasksListService(), coordinator: self)
        navigationController.pushViewController(HomeViewController(viewModel: viewModel), animated: true)
    }
    
    func showSelectedList(_ list: TasksListModel) {
        let taskListCoordinator = TaskListCoordinator(navigationController: navigationController,
                                                      taskList: list)
        taskListCoordinator.start()
    }
    
    func gotoAddList() {
        let addListCoordinator = AddListCoordinator(navigationController: navigationController)
        addListCoordinator.start()
    }
}
