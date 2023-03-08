//
//  AddTaskViewTests.swift
//  MVVM_MyToDosTests
//
//  Created by Raúl Ferrer on 17/7/22.
//

import XCTest

@testable import MVVM_MyToDos

class AddTaskViewTests: XCTestCase {

    var sut: AddTaskView!
    var taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [],
                                  createdAt: Date())
    
    let taskService = TaskService(coreDataManager: InMemoryCoreDataManager.shared)
    
    override func setUpWithError() throws {
        let viewModel = AddTaskViewModel(tasksListModel: taskList, taskService: taskService)
        sut = AddTaskView(viewModel: viewModel)
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
    
    func testTextField_whenTextfieldIsCreated_shouldBeEmpty() {
        XCTAssertEqual(sut.titleTextfield.text, "")
    }
    
    func testAddTaskButton_whenThereIsNoTitle_shouldButtonBeDisabled() {
        XCTAssertFalse(sut.addTaskButton.isEnabled)
    }
    
    func testAddTaskButton_whenThereIsTitle_shouldButtonBeEnabled() {
        sut.titleTextfield.insertText("Test title")
        XCTAssertTrue(sut.addTaskButton.isEnabled)
    }
}
