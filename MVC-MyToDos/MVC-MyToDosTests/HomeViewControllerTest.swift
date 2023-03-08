//
//  HomeViewControllerTest.swift
//  MVC-MyToDosTests
//
//  Created by Raúl Ferrer on 15/5/22.
//

import XCTest

@testable import MVC_MyToDos

class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController!
    var navigationController: MockNavigationController!
    var tasksListService: MockTaskListService!
    var taskService: MockTaskService!
    let list = TasksListModel(id: ProcessInfo().globallyUniqueString,
                              title: "Test title",
                              icon: "test.icon",
                              tasks: [TaskModel](),
                              createdAt: Date())
    
    override func setUpWithError() throws {
        tasksListService = MockTaskListService(lists: [list])
        taskService = MockTaskService(list: list)
        sut = HomeViewController(tasksListService: tasksListService, taskService: taskService)
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        taskService = nil
        super.tearDown()
    }

    func testDeleteList_whenDeletedActionIsCalled_shouldBeNoneOnDatabase() {
        sut.deleteList(list)
        XCTAssertEqual(tasksListService.fetchLists().count, 0)
    }
    
    func testPushVC_whenAddListIsCalled_thenPushAddListVCCalled() {
        sut.addListAction()
        XCTAssertTrue(navigationController.vcIsPushed)
    }
    
    func testPushVC_whenTaskListIsCalled_thenPushTaskListVCCalled() {
        sut.selectedList(TasksListModel())
        XCTAssertTrue(navigationController.vcIsPushed)
    }
}
