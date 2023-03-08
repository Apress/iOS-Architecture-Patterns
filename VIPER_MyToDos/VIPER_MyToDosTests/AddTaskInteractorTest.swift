//
//  AddTaskInteractorTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class AddTaskInteractorTest: XCTestCase {
    
    var sut: PresenterToInteractorAddTaskProtocol!
    var presenter: AddTaskPresenter!
    var router: MockAddTaskRouter!
    var view: AddTaskViewController!
    var mockTaskService: MockTaskService!
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
        mockTaskService = MockTaskService(list: taskList)
        sut = AddTaskInteractor(taskList: taskList, taskService: mockTaskService)
        presenter = AddTaskPresenter()
        router = MockAddTaskRouter()
        view = AddTaskViewController()
        presenter.router = router
        presenter.view = view
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddTask_whenATaskIsPassed_shouldBeAddedToDB() {
        sut.addTask(task: task)
        XCTAssertTrue(mockTaskService.fetchTasksForList(taskList).count == 1)
    }
    
    func testAddList_whenAListIsPassed_shouldBeNavigateToHome() {
        sut.addTask(task: task)
        XCTAssertTrue(router.isDismissed)
    }
}
