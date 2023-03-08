//
//  AddListPresenterTest.swift
//  VIP_MyToDos
//

@testable import VIP_MyToDos
import XCTest

final class AddListPresenterTest: XCTestCase {
    
    private var sut: AddListPresenter!
    private var viewController: MockAddListViewController!
    private var router: MockAddListRouter!
    
    override func setUpWithError() throws {
        super.setUp()
        viewController = MockAddListViewController()
        router = MockAddListRouter()
        viewController.router = router
        sut = AddListPresenter()
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        router = nil
        super.tearDown()
    }
    
    func testNavigateBack_whenNavigateBackIsCalled_shouldNavigateToHome() {
        sut.navigateBack()
        XCTAssertTrue(viewController.navigateBackRequest)
        XCTAssertTrue(router.navigateToHome)
    }
}

final class MockAddListViewController: AddListViewControllerInput {
    
    var router: AddListRouterDelegate?
    
    private(set) var navigateBackRequest: Bool = false

    func navigateToHome() {
        navigateBackRequest = true
        router?.navigateBack()
    }
}
