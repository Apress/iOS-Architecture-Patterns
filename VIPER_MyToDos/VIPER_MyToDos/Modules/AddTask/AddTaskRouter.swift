//
//  AddTaskRouter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

class AddTaskRouter: PresenterToRouterAddTaskProtocol {
    
    static func createScreenFor(list: TasksListModel) -> UIViewController {
        let presenter: ViewToPresenterAddTaskProtocol & InteractorToPresenterAddTaskProtocol = AddTaskPresenter()
        
        let viewController = AddTaskViewController()
        viewController.presenter = presenter
        viewController.presenter.router = AddTaskRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AddTaskInteractor(taskList: list, taskService: TaskService())
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
    func dismissFrom(view: PresenterToViewAddTaskProtocol) {
        let viewController = view as! AddTaskViewController
        viewController.dismiss(animated: true)
    }
}
