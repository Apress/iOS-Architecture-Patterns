//
//  TaskListCoordinator.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 26/7/22.
//

import UIKit

protocol TaskListCoordinatorProtocol {
    func gotoAddTask()
    func navigateBack()
}

class TaskListCoordinator: Coordinator, TaskListCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var taskList: TasksListModel!
    
    init(navigationController: UINavigationController, taskList: TasksListModel) {
        self.navigationController = navigationController
        self.taskList = taskList
    }
    
    func start() {
        let viewModel = TaskListViewModel(tasksListModel: taskList,
                                          taskService: TaskService(),
                                          tasksListService: TasksListService(),
                                          coordinator: self)
        let taskViewController = TaskListViewController(viewModel: viewModel)
        navigationController.pushViewController(taskViewController, animated: true)
    }
    
    func gotoAddTask() {
        let addTaskCoordinator = AddTaskCoordinator(navigationController: navigationController,
                                                    tasksList: taskList)
        addTaskCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
