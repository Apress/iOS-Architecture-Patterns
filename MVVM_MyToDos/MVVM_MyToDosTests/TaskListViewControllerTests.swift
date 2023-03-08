//
//  TaskListViewControllerTests.swift
//  MVVM_MyToDosTests
//
//  Created by Raúl Ferrer on 16/7/22.
//

import XCTest

@testable import MVVM_MyToDos

class TaskListViewControllerTests: XCTestCase {
    var sut: TaskListViewController!
    var navigationController: MockNavigationController!
    let list = TasksListModel(id: ProcessInfo().globallyUniqueString,
                              title: "Test title",
                              icon: "test.icon",
                              tasks: [TaskModel](),
                              createdAt: Date())

    
    override func setUpWithError() throws {
        sut = TaskListViewController(tasksListModel: list)
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testPopVC_whenBackActionIsCalled_thenPopHomeCalled() {
        sut.navigateBack()
        XCTAssertTrue(navigationController.vcIsPopped)
    }
}
