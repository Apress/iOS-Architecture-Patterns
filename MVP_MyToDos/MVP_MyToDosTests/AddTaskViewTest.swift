//
//  AddTaskViewTest.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 1/6/22.
//

import XCTest

@testable import MVP_MyToDos

class AddTaskViewTest: XCTestCase {
    
    var sut: AddTaskView!
    var presenter: AddTaskPresenter!

    override func setUpWithError() throws {
        sut = AddTaskView()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.titleTextfield)
        XCTAssertNotNil(sut.iconLabel)
        XCTAssertNotNil(sut.iconSelectorView)
        XCTAssertNotNil(sut.addTaskButton)
        XCTAssertNotNil(sut.titleLabel)
    }

    func testButtonAction_whenAddTaskButtonIsTapped_shouldBeCalledAddTaskAction() {
        let addTaskButton = sut.addTaskButton
        XCTAssertNotNil(addTaskButton, "UIButton does not exists")
        
        guard let addTaskButtonAction = addTaskButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addTaskButtonAction.contains("addTaskAction"))
    }
    
    func testTextField_whenTextfieldIsCreated_shouldBeEmpty() {
        XCTAssertEqual(sut.titleTextfield.text, "")
    }
    
    func testTextField_whenTextfiledhasText_shouldBeCreatedTask() {
        let taskList = TasksListModel(id: "12345-67890",
                                      title: "Test List",
                                      icon: "test.icon",
                                      tasks: [TaskModel](),
                                      createdAt: Date())
        let mockTaskService = MockTaskService(list: taskList)
        presenter = AddTaskPresenter(tasksListModel: taskList, taskService: mockTaskService)
        sut.presenter = presenter
        sut.titleTextfield.text = "Test title"
        sut.addTaskAction()
        XCTAssertEqual(presenter.task.title, "Test title")
    }
}
