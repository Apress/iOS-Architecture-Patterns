//
//  AddListPresenterTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class AddListPresenterTest: XCTestCase {
    
    var sut: AddListPresenter!
    var view: AddListViewController!
    var router: MockAddListRouter!
    var interactor: AddListInteractor!
    
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())

    override func setUpWithError() throws {
        sut = AddListPresenter()
        let mockTaskListService = MockTaskListService(lists: [TasksListModel]())
        interactor = AddListInteractor(tasksListService: mockTaskListService)
        interactor.presenter = sut
        view = AddListViewController()
        view.presenter = sut
        router = MockAddListRouter()
        sut.interactor = interactor
        sut.view = view
        sut.router = router
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testAddList_whenAListIsPassed_shoulNavigateToHome() {
        sut.addList(taskList: taskList)
        XCTAssertTrue(router.isPopToHome)
    }
    
    func testBackAction_whenAListIsPassed_shoulNavigateToHome() {
        sut.backAction()
        XCTAssertTrue(router.isPopToHome)
    }
}
