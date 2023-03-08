//
//  TaskListViewTest.swift
//  MVC-MyToDosTests
//
//  Created by Raúl Ferrer on 9/5/22.
//

import XCTest

@testable import MVC_MyToDos

class TaskListViewTest: XCTestCase {

    var sut: TaskListView!
    
    override func setUpWithError() throws {
        sut = TaskListView()
        let task = TaskModel(id: "12345-67890",
                             title: "Task",
                             icon: "test.icon",
                             done: true,
                             createdAt: Date())
        let list = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [task],
                                  createdAt: Date())
        sut.setTasksList(list)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.addTaskButton)
        XCTAssertNotNil(sut.emptyState)
        XCTAssertNotNil(sut.tableView)
    }


    func testButtonAction_whenAddTaskButtonIsTapped_shouldBeCalledAddTaskAction() {
        let addTaskButton = sut.addTaskButton
        XCTAssertNotNil(addTaskButton, "UIButton does not exists")
        
        guard let addListButtonAction = addTaskButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addListButtonAction.contains("addTaskAction"))
    }
    
    func testButtonAction_whenBackButtonIsTapped_shouldBeCalledBackAction() {
        let backButton = sut.backButton
        XCTAssertNotNil(backButton, "UIButton does not exists")
        
        guard let backButtonAction = backButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(backButtonAction.contains("backAction"))
    }
    
    func testEmptyState_whenModelHasZeroTask_shoulBeEmptyState() {
        let list = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
        sut.setTasksList(list)
        XCTAssertFalse(sut.emptyState.isHidden)
    }
    
    func testEmptyState_whenModelHasATask_shoulBeNoEmptyState() {
        XCTAssertTrue(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasATask_shouldBeOneRow() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableView_whenModelHasATask_shoulBeACellAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testTableView_whenTaskIsDeleted_shouldBeNoneOnModel() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertEqual(sut.tasks.count, 0)
    }
}
