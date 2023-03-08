//
//  AddTaskScenePresenterTests.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class AddTaskPresenterTests: XCTestCase {
    
    private var sut: AddTaskPresenter!
    private var viewController: MockAddTaskViewController!
    private var router: MockAddTaskRouter!
    
    override func setUpWithError() throws {
        super.setUp()
        viewController = MockAddTaskViewController()
        router = MockAddTaskRouter()
        viewController.router = router
        sut = AddTaskPresenter()
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        router = nil
        super.tearDown()
    }
    
    func testDismissView_whenDismissViewIsCalled_shouldViewDismiss() {
        sut.dismissView()
        XCTAssertTrue(viewController.dismissedView)
        XCTAssertTrue(router.dismissedView)
    }
}

final class MockAddTaskViewController: AddTaskViewControllerInput {
    
    var router: AddTaskRouterDelegate?

    private(set) var dismissedView: Bool = false
    
    func dismissView() {
        dismissedView = true
        router?.dismissView()
    }
}
