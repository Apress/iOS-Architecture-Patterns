//
//  AddListRouter.swift
//  VIP_MyToDos
//

import UIKit

protocol AddListRouterDelegate {
    func navigateBack()
}

final class AddListRouter {
    weak var viewController: UIViewController?
}

extension AddListRouter: AddListRouterDelegate {
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
