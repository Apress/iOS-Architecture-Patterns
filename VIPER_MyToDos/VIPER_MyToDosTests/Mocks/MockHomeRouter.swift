//
//  MockHomeRouter.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 14/9/22.
//

import UIKit

@testable import VIPER_MyToDos

class MockHomeRouter: PresenterToRouterHomeProtocol {
    
    var isPushedToAddList: Bool = false
    var isPushedToTasksList: Bool = false
    var selectedTaskList: TasksListModel = TasksListModel()
    
    static func createScreen() -> UINavigationController {
        UINavigationController()
    }
    
    func pushToAddListOn(view: PresenterToViewHomeProtocol) {
        isPushedToAddList = true
    }
    
    func pushToTaskListOn(view: PresenterToViewHomeProtocol, taskList: TasksListModel) {
        selectedTaskList = taskList
        isPushedToTasksList = true
    }
}
