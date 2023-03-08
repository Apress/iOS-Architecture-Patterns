//
//  MockTaskListCoordinator.swift
//  MVVM-C_MyToDosTests
//
//  Created by Raúl Ferrer on 27/7/22.
//

import Foundation

@testable import MVVM_C_MyToDos

class MockTaskListCoordinator: TaskListCoordinatorProtocol {
    
    var addedTask = 0
    var navigatedBack = 0

    func gotoAddTask() {
        addedTask += 1
    }
    
    func navigateBack() {
        navigatedBack += 1
    }    
}
