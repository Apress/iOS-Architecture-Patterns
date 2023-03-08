//
//  AddTaskInteractorTest.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class AddTaskInteractorTest: XCTestCase {
    
    private var sut: AddTaskInteractor!
    private var presenter: MockAddTaskPresenter!
    var mockTaskService: MockTaskService!
    
    var taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        super.setUp()
        presenter = MockAddTaskPresenter()
        let mockTaskListInteractor = MockTaskListInteractor()
        mockTaskService = MockTaskService(list: taskList)
        sut = AddTaskInteractor(tasksList: taskList,
                                taskService: mockTaskService,
                                delegate: mockTaskListInteractor)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testAddTask_whenRequestIsPased_shouldTaskBeAdded() {
        let request = AddTaskModel.AddTask.Request(title: "test_title", icon: "test_icon")
        sut.addTask(request: request)
        XCTAssertEqual(mockTaskService.listTasks.count, 1)
        XCTAssertTrue(presenter.dismissedView)
    }
}

final class MockAddTaskPresenter: AddTaskPresenterInput {
    
    private(set) var dismissedView: Bool = false
    
    func dismissView() {
        dismissedView = true
    }
}
