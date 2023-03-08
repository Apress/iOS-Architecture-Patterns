//
//  HomeConfigurator.swift
//  VIP_MyToDos
//

import Foundation

final class HomeConfigurator {
    
    static func configure(_ viewController: HomeViewController) -> HomeViewController {
        let interactor = HomeInteractor(tasksListService: TasksListService())
        let presenter = HomePresenter()
        let router = HomeRouter()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
