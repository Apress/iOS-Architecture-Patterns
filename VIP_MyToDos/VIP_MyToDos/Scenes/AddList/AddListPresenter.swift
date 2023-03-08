//
//  AddListPresenter.swift
//  VIP_MyToDos
//

import UIKit

typealias AddListPresenterInput = AddListInteractorOutput
typealias AddListPresenterOutput = AddListViewControllerInput

final class AddListPresenter {
    weak var viewController: AddListPresenterOutput?
}

extension AddListPresenter: AddListPresenterInput {
    
    func navigateBack() {
        viewController?.navigateToHome()
    }
}
