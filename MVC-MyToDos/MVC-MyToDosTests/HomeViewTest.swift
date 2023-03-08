//
//  HomeViewTest.swift
//  MVC-MyToDosTests
//
//  Created by Raúl Ferrer on 7/5/22.
//

import XCTest

@testable import MVC_MyToDos

class HomeViewTest: XCTestCase {

    var sut: HomeView!
    
    override func setUpWithError() throws {
        sut = HomeView()
        let list = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
        sut.setTasksLists([list])
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.addListButton)
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.emptyState)
    }
    
    func testEmptyState_whenModelHasAList_shoulBeNoEmptyState() {
        XCTAssertTrue(sut.emptyState.isHidden)
    }

    func testButtonAction_whenAddListButtonIsTapped_shouldBeCalledAddListAction() {
        let addListButton = sut.addListButton
        XCTAssertNotNil(addListButton, "UIButton does not exists")
        
        guard let addListButtonAction = addListButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addListButtonAction.contains("addListAction"))
    }
    
    func testTableView_whenModelHasZeroList_shoulBeEmptyState() {
        sut.setTasksLists([TasksListModel]())
        XCTAssertFalse(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasAList_shouldBeOneRow() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        
    }
    
    func testTableView_whenModelHasAList_shoulBeACellAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testTableView_whenListIsDeleted_shouldBeNoneOnModel() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertEqual(sut.tasksList.count, 0)
    }
}
