//
//  MockAddTaskCoordinator.swift
//  MVVM-C_MyToDosTests
//
//  Created by Raúl Ferrer on 28/7/22.
//

import UIKit

@testable import MVVM_C_MyToDos

class MockAddTaskCoordinator: AddTaskCoordinatorProtocol {

    var dismissView = 0

    func dismiss() {
        dismissView += 1
    }
}
