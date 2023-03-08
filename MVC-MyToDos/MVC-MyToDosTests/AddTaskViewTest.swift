//
//  AddTaskViewTest.swift
//  MVC-MyToDosTests
//
//  Created by Raúl Ferrer on 15/5/22.
//

import XCTest

@testable import MVC_MyToDos


class AddTaskViewTest: XCTestCase {
    
    var sut: AddTaskView!

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
        sut.titleTextfield.text = "Test title"
        sut.addTaskAction()
        XCTAssertEqual(sut.taskModel.title, "Test title")
    }
}
