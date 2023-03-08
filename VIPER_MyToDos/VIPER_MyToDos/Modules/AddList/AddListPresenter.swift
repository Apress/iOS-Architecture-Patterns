//
//  AddListPresenter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class AddListPresenter: ViewToPresenterAddListProtocol {

    var view: PresenterToViewAddListProtocol?
    var interactor: PresenterToInteractorAddListProtocol?
    var router: PresenterToRouterAddListProtocol?
    
    func addList(taskList: TasksListModel) {
        interactor?.addList(taskList: taskList)
    }
    
    func backAction() {
        router?.popToHomeFrom(view: view!)
    }
}

extension AddListPresenter: InteractorToPresenterAddListProtocol {
    
    func addedList() {
        router?.popToHomeFrom(view: view!)
    }
}
