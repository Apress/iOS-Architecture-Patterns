//
//  AddListProtocols.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

// MARK: Router Input
protocol PresenterToRouterAddListProtocol {
    static func createScreen() -> UIViewController
    
    func popToHomeFrom(view: PresenterToViewAddListProtocol)
}

// MARK: View Input
protocol ViewToPresenterAddListProtocol {
    var view: PresenterToViewAddListProtocol? { get set }
    var interactor: PresenterToInteractorAddListProtocol? { get set }
    var router: PresenterToRouterAddListProtocol? { get set }
    
    func addList(taskList: TasksListModel)
    func backAction()
}

// MARK: View Output
protocol PresenterToViewAddListProtocol {}

// MARK: Interactor Input
protocol PresenterToInteractorAddListProtocol {
    var presenter: InteractorToPresenterAddListProtocol? { get set }

    func addList(taskList: TasksListModel)
}

// MARK: Interactor Output
protocol InteractorToPresenterAddListProtocol {
    func addedList()
}
