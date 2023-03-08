//
//  AddTaskPresenter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class AddTaskPresenter: ViewToPresenterAddTaskProtocol {
    
    var view: PresenterToViewAddTaskProtocol?
    var interactor: PresenterToInteractorAddTaskProtocol?
    var router: PresenterToRouterAddTaskProtocol?
    
    func addTask(task: TaskModel) {
        interactor?.addTask(task: task)
    }
}


extension AddTaskPresenter: InteractorToPresenterAddTaskProtocol {
    
    func addedTask() {
        router?.dismissFrom(view: view!)
    }
}
