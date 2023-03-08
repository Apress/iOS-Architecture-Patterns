//
//  AddTaskConfigurator.swift
//  VIP_MyToDos
//

import Foundation

final class AddTaskConfigurator {
    
    static func configure( _ viewController: AddTaskViewController, delegate: AddTaskDelegate, tasksList: TasksListModel) -> AddTaskViewController {
        
        let interactor = AddTaskInteractor(tasksList: tasksList, taskService: TaskService(), delegate: delegate)
        let presenter = AddTaskPresenter()
        let router = AddTaskRouter()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
