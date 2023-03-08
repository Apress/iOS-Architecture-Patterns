//
//  AddTaskViewControllerTest.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class AddTaskViewControllerTest: XCTestCase {
    
    private var sut: AddTaskViewController!
    private var interactor: MockAddTaskInteractor!
    private var router: MockAddTaskRouter!
    private var view: AddTaskView!
    
    override func setUpWithError() throws {
        super.setUp()
        interactor = MockAddTaskInteractor()
        router = MockAddTaskRouter()
        view = AddTaskView()
        sut = AddTaskViewController(addTaskView: view)
        sut.interactor = interactor
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        view = nil
        super.tearDown()
    }
    
    func testAddTAsk_whenTitleAndIconIsPassed_shouldInfoBePassed() {
        sut.addTaskWith(title: "test_title", icon: "test_icon")
        XCTAssertEqual(interactor.taskTitle, "test_title")
        XCTAssertEqual(interactor.taskIcon, "test_icon")
    }
}

final class MockAddTaskInteractor: AddTaskInteractorInput {
    
    private(set) var taskTitle: String = ""
    private(set) var taskIcon: String = ""
    
    func addTask(request: AddTaskModel.AddTask.Request) {
        taskTitle = request.title
        taskIcon = request.icon
    }
}

final class MockAddTaskRouter: AddTaskRouterDelegate {

    private(set) var dismissedView: Bool = false

    func dismissView() {
        dismissedView = true
    }
}
