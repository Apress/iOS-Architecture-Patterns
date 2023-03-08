//
//  HomeRouter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    static func createScreen() -> UINavigationController {
        
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        let viewController = HomeViewController()
        viewController.presenter = presenter
        viewController.presenter.router = HomeRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomeInteractor(tasksListService: TasksListService())
        viewController.presenter?.interactor?.presenter = presenter

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
    func pushToAddListOn(view: PresenterToViewHomeProtocol) {
        let addListController = AddListRouter.createScreen()
        let viewController = view as! HomeViewController
        viewController.navigationController?
            .pushViewController(addListController, animated: true)
    }
    
    func pushToTaskListOn(view: PresenterToViewHomeProtocol, taskList: TasksListModel) {
        let taskListController = TaskListRouter.createScreenFor(list: taskList)
        let viewController = view as! HomeViewController
        viewController.navigationController?
            .pushViewController(taskListController, animated: true)
    }
}
