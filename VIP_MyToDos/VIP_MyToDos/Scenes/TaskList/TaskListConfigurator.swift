//
//  TaskListConfigurator.swift
//  VIP_MyToDos
//

import Foundation

final class TaskListConfigurator {
    
    static func configure( _ viewController: TaskListViewController, delegate: SelectedListDelegate, tasksList: TasksListModel) -> TaskListViewController {
        
        let interactor = TaskListInteractor(tasksList: tasksList,
                                            taskService: TaskService(), 
                                            tasksListService: TasksListService(),
                                            delegate: delegate)
        let presenter = TaskListPresenter()
        let router = TaskListRouter()
        router.viewController = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
