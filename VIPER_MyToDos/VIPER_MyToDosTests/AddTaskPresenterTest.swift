//
//  AddTaskPresenterTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class AddTaskPresenterTest: XCTestCase {
    
    var sut: AddTaskPresenter!
    var view: AddTaskViewController!
    var router: MockAddTaskRouter!
    var interactor: AddTaskInteractor!

    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    let task = TaskModel(id: "12345-67890",
                         title: "Test Task",
                         icon: "test.icon",
                         done: false,
                         createdAt: Date())
    
    override func setUpWithError() throws {
        sut = AddTaskPresenter()
        let mockTaskService = MockTaskService(list: taskList)
        interactor = AddTaskInteractor(taskList: taskList, taskService: mockTaskService)
        interactor.presenter = sut
        view = AddTaskViewController()
        view.presenter = sut
        router = MockAddTaskRouter()
        sut.interactor = interactor
        sut.view = view
        sut.router = router
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddTask_whenOneTaskIsAdded_shoulBeOneTask() {
        sut.addTask(task: task)
        XCTAssertTrue(router.isDismissed)
    }
}
