//
//  AddListControllerTests.swift
//  MVVM_MyToDosTests
//
//  Created by Raúl Ferrer on 16/7/22.
//

import XCTest

@testable import MVVM_MyToDos

class AddListViewControllerTest: XCTestCase {
    
    var sut: AddListViewController!
    var navigationController: MockNavigationController!
    
    override func setUpWithError() throws {
        sut = AddListViewController()
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
        navigationController.vcIsPushed = false
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
