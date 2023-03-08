//
//  AddListInteractor.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class AddListInteractor: PresenterToInteractorAddListProtocol {
    
    var presenter: InteractorToPresenterAddListProtocol?
    var tasksListService: TasksListServiceProtocol!
    
    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
    }
    
    func addList(taskList: TasksListModel) {
        tasksListService.saveTasksList(taskList)
        presenter?.addedList()
    }
}
