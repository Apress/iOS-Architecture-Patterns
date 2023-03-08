//
//  AddListInteractorTests.swift
//  VIP_MyToDos
//

@testable import VIP_MyToDos
import XCTest

final class AddListInteractorTest: XCTestCase {
    
    private var sut: AddListInteractor!
    private var presenter: AddListPresenterMock!
    private var mockTaskListService: MockTaskListService!
    
    override func setUpWithError() throws {
        super.setUp()
        presenter = AddListPresenterMock()
        mockTaskListService = MockTaskListService(lists: [TasksListModel]())
        let mockHomeInteractor = MockHomeInteractor()
        sut = AddListInteractor(tasksListService: mockTaskListService,
                                delegate: mockHomeInteractor)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testAddList_whenRequestIsPased_shouldListBeAdded() {
        let request = AddListModel.AddList.Request(title: "test_title", icon: "test_icon")
        sut.addList(request: request)
        XCTAssertEqual(mockTaskListService.lists.count, 1)
        XCTAssertTrue(presenter.navigateBackRequest)
    }
}

final class AddListPresenterMock: AddListPresenterInput {
    
    private(set) var navigateBackRequest: Bool = false

    func navigateBack() {
        navigateBackRequest = true
    }
}
