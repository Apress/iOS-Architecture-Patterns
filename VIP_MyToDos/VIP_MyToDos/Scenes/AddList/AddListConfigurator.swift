//
//  AddListConfigurator.swift
//  VIP_MyToDos
//

import Foundation

final class AddListConfigurator {
    
    static func configure( _ viewController: AddListViewController, delegate: AddListDelegate) -> AddListViewController  {
    
        let interactor = AddListInteractor(tasksListService: TasksListService(), delegate: delegate)
        let presenter = AddListPresenter()
        let router = AddListRouter()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
