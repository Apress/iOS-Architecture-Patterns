//
//  MockAddListRouter.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import UIKit

@testable import VIPER_MyToDos

class MockAddListRouter: PresenterToRouterAddListProtocol {
    
    var isPopToHome: Bool = false

    static func createScreen() -> UIViewController {
        return UIViewController()
    }
    
    func popToHomeFrom(view: PresenterToViewAddListProtocol) {
        isPopToHome = true
    }
}
