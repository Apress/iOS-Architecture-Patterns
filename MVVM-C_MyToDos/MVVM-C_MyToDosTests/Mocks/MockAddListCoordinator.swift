//
//  MockAddListCoordinator.swift
//  MVVM-C_MyToDosTests
//
//  Created by Raúl Ferrer on 27/7/22.
//

import Foundation

@testable import MVVM_C_MyToDos

class MockAddListCoordinator: AddListCoordinatorProtocol {
    
    var navigatedBack = 0

    func navigateBack() {
        navigatedBack += 1
    }
}
