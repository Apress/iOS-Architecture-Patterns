//
//  HomePresenter.swift
//  VIP_MyToDos
//

import UIKit

typealias HomePresenterInput = HomeInteractorOutput
typealias HomePresenterOutput = HomeViewControllerInput

final class HomePresenter {
    weak var viewController: HomePresenterOutput?
}

extension HomePresenter: HomePresenterInput {
    
    func presentTasksLists(response: HomeModel.FetchTasksLists.Response) {
        let viewModel = HomeModel.FetchTasksLists.ViewModel(tasksLists: response.tasksLists)
        viewController?.reloadDataWithTaskList(viewModel: viewModel)
    }

    func showAddTaskList(response: HomeModel.AddTasksList.Response) {
        let viewModel = HomeModel.AddTasksList.ViewModel(addListDelegate: response.addListDelegate)
        viewController?.showAddListView(viewModel: viewModel)
    }
    
    func showSelectedList(response: HomeModel.SelectTasksList.Response) {
        let viewModel = HomeModel.SelectTasksList.ViewModel(selectedListDelegate: response.selectedListDelegate, tasksList: response.tasksList)
        viewController?.showSelectedList(viewModel: viewModel)
    }
}
