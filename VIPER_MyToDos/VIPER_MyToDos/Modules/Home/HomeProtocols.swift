//
//  HomeProtocols.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

// MARK: Router Input
protocol PresenterToRouterHomeProtocol {
    static func createScreen() -> UINavigationController
    
    func pushToAddListOn(view: PresenterToViewHomeProtocol)
    func pushToTaskListOn(view: PresenterToViewHomeProtocol, taskList: TasksListModel)
}

// MARK: View Input
protocol ViewToPresenterHomeProtocol {
    var view: PresenterToViewHomeProtocol? { get set }
    var interactor: PresenterToInteractorHomeProtocol? { get set }
    var router: PresenterToRouterHomeProtocol? { get set }
        
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func listAt(indexPath: IndexPath) -> TasksListModel
    func selectRowAt(indexPath: IndexPath)
    func deleteRowAt(indexPath: IndexPath)
    func addTaskList()
}

// MARK: View Output
protocol PresenterToViewHomeProtocol {
    func onFetchLists()
    func showEmptyState()
    func hideEmptyState()
}

// MARK: Interactor Input
protocol PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol? { get set }

    func loadLists()
    func getListAt(indexPath: IndexPath)
    func deleteListAt(indexPath: IndexPath)
}

// MARK: Interactor Output
protocol InteractorToPresenterHomeProtocol {
    func fetchedLists(taskLists: [TasksListModel])
    func selectedList(taskList: TasksListModel?)
}
