//
//  MockHomeCoordinator.swift
//  MVVM-C_MyToDosTests
//
//  Created by Raúl Ferrer on 27/7/22.
//

import Foundation

@testable import MVVM_C_MyToDos

class MockHomeCoordinator: HomeCoordinatorProtocol {
    
    var addedList = 0
    var selectedList = TasksListModel()
    
    func showSelectedList(_ list: TasksListModel) {
        selectedList = list
    }
    
    func gotoAddList() {
        addedList += 1
    }
}
