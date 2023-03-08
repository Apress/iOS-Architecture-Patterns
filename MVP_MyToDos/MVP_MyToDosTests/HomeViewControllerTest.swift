//
//  HomeViewControllerTest.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 1/6/22.
//

import XCTest

@testable import MVP_MyToDos

class HomeViewControllerTest: XCTestCase {
    
    var sut: HomeViewController!
    var navigationController: MockNavigationController!

    override func setUpWithError() throws {
        sut = HomeViewController()
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testPushVC_whenAddListIsCalled_thenPushAddListVCCalled() {
        sut.addList()
        XCTAssertTrue(navigationController.vcIsPushed)
    }
    
    func testPushVC_whenTaskListIsCalled_thenPushTaskListVCCalled() {
        sut.selectedList(TasksListModel())
        XCTAssertTrue(navigationController.vcIsPushed)
    }
}
