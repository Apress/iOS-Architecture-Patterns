//
//  HomePresenter.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import Foundation

class HomePresenter {
    
    private weak var homeView: HomeViewDelegate?
    private var tasksListService: TasksListServiceProtocol!
    private var lists: [TasksListModel] = [TasksListModel]()
            
    init(homeView: HomeViewDelegate? = nil,
         tasksListService: TasksListServiceProtocol) {
        self.homeView = homeView
        self.tasksListService = tasksListService
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasksLists()
    }
    
    func fetchTasksLists() {
        lists = tasksListService.fetchLists()
        homeView?.reloadData()
    }
    
    var numberOfTaskLists: Int {
        return lists.count
    }
    
    func listAtIndex(_ index: Int) -> TasksListModel {
        return lists[index]
    }
    
    func removeListAtIndex(_ index: Int) {
        let list = listAtIndex(index)
        tasksListService.deleteList(list)
        lists.remove(at: index)
    }
}
