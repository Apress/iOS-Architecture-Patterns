//
//  AddTskProtocols.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

// MARK: Router Input
protocol PresenterToRouterAddTaskProtocol {
    static func createScreenFor(list: TasksListModel) -> UIViewController
    
    func dismissFrom(view: PresenterToViewAddTaskProtocol)
}

// MARK: View Input
protocol ViewToPresenterAddTaskProtocol {
    var view: PresenterToViewAddTaskProtocol? { get set }
    var interactor: PresenterToInteractorAddTaskProtocol? { get set }
    var router: PresenterToRouterAddTaskProtocol? { get set }
    
    func addTask(task: TaskModel)
}

// MARK: View Output
protocol PresenterToViewAddTaskProtocol {}

// MARK: Interactor Input
protocol PresenterToInteractorAddTaskProtocol {
    
    var presenter: InteractorToPresenterAddTaskProtocol? { get set }

    func addTask(task: TaskModel)
}

// MARK: Interactor Output
protocol InteractorToPresenterAddTaskProtocol {
    func addedTask()
}
