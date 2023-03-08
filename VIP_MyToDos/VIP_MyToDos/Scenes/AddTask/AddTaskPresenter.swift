//
//  AddTaskPresenter.swift
//  VIP_MyToDos
//

import UIKit

typealias AddTaskPresenterInput = AddTaskInteractorOutput
typealias AddTaskPresenterOutput = AddTaskViewControllerInput

final class AddTaskPresenter {
    weak var viewController: AddTaskPresenterOutput?
}

extension AddTaskPresenter: AddTaskPresenterInput {
    
    func dismissView() {
        viewController?.dismissView()
    }
}
