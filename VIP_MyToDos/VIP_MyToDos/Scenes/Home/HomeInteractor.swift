//
//  HomeInteractor.swift
//  VIP_MyToDos
//

import Foundation

protocol HomeInteractorOutput: AnyObject {
    func presentTasksLists(response: HomeModel.FetchTasksLists.Response)
    func showAddTaskList(response: HomeModel.AddTasksList.Response)
    func showSelectedList(response: HomeModel.SelectTasksList.Response)
}

typealias HomeInteractorInput = HomeViewControllerOutput

final class HomeInteractor {
    var presenter: HomePresenterInput?
    
    private var lists = [TasksListModel]()
    private let tasksListService: TasksListServiceProtocol!
    
    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
    }
    
    func fetchTasksLists() {
        fetchTasksLists(request: HomeModel.FetchTasksLists.Request())
    }
}

extension HomeInteractor: HomeInteractorInput {
    
    func addList(request: HomeModel.AddTasksList.Request) {
        let response = HomeModel.AddTasksList.Response(addListDelegate: self)
        presenter?.showAddTaskList(response: response)
    }
    
    func fetchTasksLists(request: HomeModel.FetchTasksLists.Request) {
        lists = tasksListService.fetchLists()
        let response = HomeModel.FetchTasksLists.Response(tasksLists: lists)
        presenter?.presentTasksLists(response: response)
    }
    
    func selectList(request: HomeModel.SelectTasksList.Request) {
        let list = lists[request.index.row]
        let response = HomeModel.SelectTasksList.Response(selectedListDelegate: self, tasksList: list)
        presenter?.showSelectedList(response: response)
    }
    
    func removeList(request: HomeModel.RemoveTasksList.Request) {
        let list = lists[request.index.row]
        tasksListService.deleteList(list)
        lists.remove(at: request.index.row)
        let response = HomeModel.FetchTasksLists.Response(tasksLists: lists)
        presenter?.presentTasksLists(response: response)
    }
}

extension HomeInteractor: AddListDelegate {
    
    func didAddList() {
        fetchTasksLists()
    }
}

extension HomeInteractor: SelectedListDelegate {
    
    func updateLists() {
        fetchTasksLists()
    }
}
