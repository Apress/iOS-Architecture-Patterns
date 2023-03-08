//
//  HomePresenter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class HomePresenter: ViewToPresenterHomeProtocol {
    
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    var lists: [TasksListModel] = [TasksListModel]()

    func viewDidLoad() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fetchLists),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
        interactor?.loadLists()
    }

    func numberOfRowsInSection() -> Int {
        return lists.count
    }
    
    func listAt(indexPath: IndexPath) -> TasksListModel {
        lists[indexPath.row]
    }
    
    func selectRowAt(indexPath: IndexPath) {
        interactor?.getListAt(indexPath: indexPath)
    }
    
    func deleteRowAt(indexPath: IndexPath) {
        interactor?.deleteListAt(indexPath: indexPath)
    }
    
    func addTaskList() {
        router?.pushToAddListOn(view: view!)
    }
    
    @objc private func fetchLists() {
        interactor?.loadLists()
    }
}


extension HomePresenter: InteractorToPresenterHomeProtocol {
    
    func fetchedLists(taskLists: [TasksListModel]) {
        lists = taskLists
        taskLists.count == 0 ? view?.showEmptyState() : view?.hideEmptyState()
        view?.onFetchLists()
    }
    
    func selectedList(taskList: TasksListModel?) {
        guard let taskList = taskList else {
            return
        }
        router?.pushToTaskListOn(view: view!, taskList: taskList)
    }
}
