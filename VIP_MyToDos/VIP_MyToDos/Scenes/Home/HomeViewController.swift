//
//  HomeViewController.swift
//  VIP_MyToDos
//

import UIKit

protocol HomeViewControllerInput: AnyObject {
    func reloadDataWithTaskList(viewModel: HomeModel.FetchTasksLists.ViewModel)
    func showAddListView(viewModel: HomeModel.AddTasksList.ViewModel)
    func showSelectedList(viewModel: HomeModel.SelectTasksList.ViewModel)
}

protocol HomeViewControllerOutput: AnyObject {
    func fetchTasksLists(request: HomeModel.FetchTasksLists.Request)
    func addList(request: HomeModel.AddTasksList.Request)
    func selectList(request: HomeModel.SelectTasksList.Request)
    func removeList(request: HomeModel.RemoveTasksList.Request)
}

final class HomeViewController: UIViewController {
    var interactor: HomeInteractorInput?
    var router: HomeRouterDelegate?
    
    private let homeView: HomeView
    
    init(homeView: HomeView) {
        self.homeView = homeView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
        self.view = homeView
        fetchTasksLists()
    }
    
    private func fetchTasksLists() {
        let request = HomeModel.FetchTasksLists.Request()
        interactor?.fetchTasksLists(request: request)
    }
}

extension HomeViewController: HomeViewControllerInput {
    
    func showAddListView(viewModel: HomeModel.AddTasksList.ViewModel) {
        router?.showAddListView(delegate: viewModel.addListDelegate)
    }
    
    func reloadDataWithTaskList(viewModel: HomeModel.FetchTasksLists.ViewModel) {
        homeView.showTasks(lists: viewModel.tasksLists)
    }
    
    func showSelectedList(viewModel: HomeModel.SelectTasksList.ViewModel) {
        router?.showSelectedList(delegate: viewModel.selectedListDelegate, list: viewModel.tasksList)
    }
}

extension HomeViewController: HomeViewDelegate {
    
    func addList() {
        let request = HomeModel.AddTasksList.Request()
        interactor?.addList(request: request)
    }
    
    func selectedListAt(index: IndexPath) {
        let request = HomeModel.SelectTasksList.Request(index: index)
        interactor?.selectList(request: request)
    }
    
    func deleteListAt(indexPath: IndexPath) {
        let request = HomeModel.RemoveTasksList.Request(index: indexPath)
        interactor?.removeList(request: request)
    }
}
