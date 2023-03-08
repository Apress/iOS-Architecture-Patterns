//
//  AddTaskRouter.swift
//  VIP_MyToDos
//

import UIKit

protocol AddTaskRouterDelegate {
    func dismissView()
}

final class AddTaskRouter {
    weak var viewController: UIViewController?
}

extension AddTaskRouter: AddTaskRouterDelegate {
    
    func dismissView() {
        viewController?.dismiss(animated: true)
    }
}
