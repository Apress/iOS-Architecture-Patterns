//
//  HomeRouter.swift
//  VIP_MyToDos
//

import UIKit

protocol HomeRouterDelegate {
    func showAddListView(delegate: AddListDelegate)
    func showSelectedList(delegate: SelectedListDelegate, list: TasksListModel)
}

final class HomeRouter {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
}

extension HomeRouter: HomeRouterDelegate {
    
    func showAddListView(delegate: AddListDelegate) {
        let addListViewController = AddListViewController(addListView: AddListView())
        viewController?.navigationController?.pushViewController(AddListConfigurator.configure(addListViewController, delegate: delegate), animated: true)
    }
    
    func showSelectedList(delegate: SelectedListDelegate, list: TasksListModel) {
        let taskListController = TaskListViewController(taskListView: TaskListView())
        viewController?.navigationController?.pushViewController(TaskListConfigurator.configure(taskListController, delegate: delegate, tasksList: list), animated: true)
    }
}
