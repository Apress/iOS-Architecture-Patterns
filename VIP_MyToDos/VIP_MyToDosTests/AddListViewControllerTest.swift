//
//  AddListViewControllerTest.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class AddListViewControllerTest: XCTestCase {
    
    private var sut: AddListViewController!
    private var interactor: MockAddListInteractor!
    private var router: MockAddListRouter!
    private var view: AddListView!
    
    override func setUpWithError() throws {
        super.setUp()
        interactor = MockAddListInteractor()
        router = MockAddListRouter()
        view = AddListView()
        sut = AddListViewController(addListView: view)
        sut.interactor = interactor
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        view = nil
        super.tearDown()
    }
    
    func testAddList_whenTitleAndIconIsPassed_shouldInfoBePassed() {
        sut.addListWith(title: "test_title", icon: "test_icon")
        XCTAssertEqual(interactor.listTitle, "test_title")
        XCTAssertEqual(interactor.listIcon, "test_icon")
    }
    
    func testAddList_whenNavigateBackIsSelected_shouldCallNavigateBack() {
        sut.navigateBack()
        XCTAssertTrue(interactor.navigateBackRequest)
    }
}

final class MockAddListInteractor: AddListInteractorInput {
    
    private(set) var navigateBackRequest: Bool = false
    private(set) var listTitle: String = ""
    private(set) var listIcon: String = ""
    
    func navigateBack() {
        navigateBackRequest = true
    }
    
    func addList(request: AddListModel.AddList.Request) {
        listTitle = request.title
        listIcon = request.icon
    }
}

final class MockAddListRouter: AddListRouterDelegate {
    
    private(set) var navigateToHome: Bool = false
    
    func navigateBack() {
        navigateToHome = true
    }
}
