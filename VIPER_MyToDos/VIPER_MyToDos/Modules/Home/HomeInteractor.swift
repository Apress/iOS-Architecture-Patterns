//
//  HomeInteractor.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class HomeInteractor: PresenterToInteractorHomeProtocol {
    
    var presenter: InteractorToPresenterHomeProtocol?
    var lists: [TasksListModel] = [TasksListModel]()
    var tasksListService: TasksListServiceProtocol!
    
    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
    }
    
    func loadLists() {
        lists = (tasksListService?.fetchLists())!
        presenter?.fetchedLists(taskLists: lists)
    }
    
    func getListAt(indexPath: IndexPath) {
        guard lists.indices.contains(indexPath.row) else {
            presenter?.selectedList(taskList: nil)
            return
        }
        presenter?.selectedList(taskList: lists[indexPath.row])
    }
    
    func deleteListAt(indexPath: IndexPath) {
        guard lists.indices.contains(indexPath.row) else { return }
        tasksListService.deleteList(lists[indexPath.row])
    }
}
