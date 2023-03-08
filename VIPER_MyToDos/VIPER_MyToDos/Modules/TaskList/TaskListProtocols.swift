//
//  TaskListProtocols.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import UIKit

// MARK: Router Input
protocol PresenterToRouterTaskListProtocol {
    static func createScreenFor(list: TasksListModel) -> UIViewController
    
    func presentAddTaskOn(view: PresenterToViewTaskListProtocol, forTaskList: TasksListModel)
    func popToHomeFrom(view: PresenterToViewTaskListProtocol)
}

// MARK: View Input
protocol ViewToPresenterTaskListProtocol {
    var view: PresenterToViewTaskListProtocol? { get set }
    var interactor: PresenterToInteractorTaskListProtocol? { get set }
    var router: PresenterToRouterTaskListProtocol? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func taskAt(indexPath: IndexPath) -> TaskModel
    func deleteRowAt(indexPath: IndexPath)
    func update(task: TaskModel)
    func addTask()
    func backAction()
}

// MARK: View Output
protocol PresenterToViewTaskListProtocol {
    func onFetchTasks()
    func showEmptyState()
    func hideEmptyState()
}

// MARK: Interactor Input
protocol PresenterToInteractorTaskListProtocol {
    
    var presenter: InteractorToPresenterTaskListProtocol? { get set }

    func loadTasks()
    func deleteTaskAt(indexPath: IndexPath)
    func updateTask(task: TaskModel)
    func addTask()
}

// MARK: Interactor Output
protocol InteractorToPresenterTaskListProtocol {
    func fetchedTasks(tasks: [TaskModel])
    func addTaskTo(list: TasksListModel)
}

