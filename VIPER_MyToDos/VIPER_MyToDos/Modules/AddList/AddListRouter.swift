//
//  AddListRouter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

class AddListRouter: PresenterToRouterAddListProtocol {
        
    static func createScreen() -> UIViewController {
        let presenter: ViewToPresenterAddListProtocol & InteractorToPresenterAddListProtocol = AddListPresenter()
        
        let viewController = AddListViewController()
        viewController.presenter = presenter
        viewController.presenter.router = AddListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AddListInteractor(tasksListService: TasksListService())
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
    func popToHomeFrom(view: PresenterToViewAddListProtocol) {
        let viewController = view as! AddListViewController
        viewController.navigationController?.popViewController(animated: true)
    }
}
