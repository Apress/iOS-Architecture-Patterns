//
//  MockTaskListRouter.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import UIKit

@testable import VIPER_MyToDos

class MockTaskListRouter: PresenterToRouterTaskListProtocol {
    
    var isPresentAddTAsk: Bool = false
    var isPopToHome: Bool = false
    var selectedTaskList: TasksListModel = TasksListModel()

    static func createScreenFor(list: TasksListModel) -> UIViewController {
        return UIViewController()
    }
    
    func presentAddTaskOn(view: PresenterToViewTaskListProtocol, forTaskList: TasksListModel) {
        isPresentAddTAsk = true
        selectedTaskList = forTaskList
    }
    
    func popToHomeFrom(view: PresenterToViewTaskListProtocol) {
        isPopToHome = true
    }
}
