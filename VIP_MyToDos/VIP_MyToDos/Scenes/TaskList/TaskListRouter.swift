//
//  TaskListRouter.swift
//  VIP_MyToDos
//

import UIKit

protocol TaskListRouterDelegate {
    func navigateBack()
    func showAddTaskView(delegate: AddTaskDelegate, tasksList: TasksListModel)
}

final class TaskListRouter {
    weak var viewController: UIViewController?
}

extension TaskListRouter: TaskListRouterDelegate {
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showAddTaskView(delegate: AddTaskDelegate, tasksList: TasksListModel) {
        let addTaskViewController = AddTaskViewController(addTaskView: AddTaskView())
        viewController?.present(AddTaskConfigurator.configure(addTaskViewController, delegate: delegate, tasksList: tasksList), animated: true)
    }
}
