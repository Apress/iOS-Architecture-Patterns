//
//  AddListInteractorTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class AddListInteractorTest: XCTestCase {
    
    var sut: PresenterToInteractorAddListProtocol!
    var presenter: AddListPresenter!
    var router: MockAddListRouter!
    var view: AddListViewController!
    var mockTaskListService: MockTaskListService!
    
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())

    override func setUpWithError() throws {
        mockTaskListService = MockTaskListService(lists: [TasksListModel]())
        sut = AddListInteractor(tasksListService: mockTaskListService)
        presenter = AddListPresenter()
        router = MockAddListRouter()
        view = AddListViewController()
        presenter.router = router
        presenter.view = view
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddList_whenAListIsPassed_shouldBeAddedToDB() {
        sut.addList(taskList: taskList)
        XCTAssertTrue(mockTaskListService.fetchLists().count == 1)
    }
    
    func testAddList_whenAListIsPassed_shouldBeNavigateToHome() {
        sut.addList(taskList: taskList)
        XCTAssertTrue(router.isPopToHome)
    }
}
