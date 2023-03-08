//
//  TaskListRouter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

class TaskListRouter: PresenterToRouterTaskListProtocol {
    
    static func createScreenFor(list: TasksListModel) -> UIViewController {
        let presenter: ViewToPresenterTaskListProtocol & InteractorToPresenterTaskListProtocol = TaskListPresenter()
        
        let viewController = TaskListViewController()
        viewController.presenter = presenter
        viewController.presenter.router = TaskListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TaskListInteractor(taskList: list, taskService: TaskService())
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
    func presentAddTaskOn(view: PresenterToViewTaskListProtocol, forTaskList: TasksListModel) {
        let addTaskController = AddTaskRouter.createScreenFor(list: forTaskList)
        let viewController = view as! TaskListViewController
        addTaskController.modalPresentationStyle = .pageSheet
        viewController.present(addTaskController, animated: true)
    }
    
    func popToHomeFrom(view: PresenterToViewTaskListProtocol) {
        let viewController = view as! TaskListViewController
        viewController.navigationController?.popViewController(animated: true)
    }    
}
