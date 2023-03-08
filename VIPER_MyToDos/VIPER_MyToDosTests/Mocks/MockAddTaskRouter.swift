//
//  MockAddTaskRouter.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import UIKit

@testable import VIPER_MyToDos

class MockAddTaskRouter: PresenterToRouterAddTaskProtocol {

    var isDismissed: Bool = false

    static func createScreenFor(list: TasksListModel) -> UIViewController {
        return UIViewController()
    }
    
    func dismissFrom(view: PresenterToViewAddTaskProtocol) {
        isDismissed = true
    }
}
