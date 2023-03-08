//
//  AddListPresenterTest.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 31/5/22.
//

import XCTest

@testable import MVP_MyToDos

class AddListPresenterTest: XCTestCase {
    
    var sut: AddListPresenter!
    let mockTaskListService = MockTaskListService(lists: [TasksListModel]())
    override func setUpWithError() throws {
        sut = AddListPresenter(tasksListService: mockTaskListService)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddIcon_whenAddedIcon_shouldContainObjectIcon() {
        sut.setListIcon("test.icon")
        XCTAssertEqual(sut.list.icon, "test.icon")
    }
    
    func testAddTitle_whenAddedTitle_shouldContainObjectTitle() {
        sut.addListWithTitle("Test List")
        XCTAssertEqual(sut.list.title, "Test List")
        XCTAssertEqual(mockTaskListService.fetchLists().first?.title, "Test List")
    }
}
