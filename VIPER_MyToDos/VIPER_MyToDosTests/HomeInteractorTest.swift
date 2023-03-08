//
//  HomeInteractorTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 4/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class HomeInteractorTest: XCTestCase {
    
    var sut: PresenterToInteractorHomeProtocol!
    var presenter: HomePresenter!
    var router: MockHomeRouter!
    var view: HomeViewController!
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        let mockTaskListService = MockTaskListService(lists: [taskList])
        sut = HomeInteractor(tasksListService: mockTaskListService)
        presenter = HomePresenter()
        router = MockHomeRouter()
        view = HomeViewController()
        presenter.router = router
        presenter.view = view
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testLoadLists_whenLoadLists_shouldBeOneList() {
        sut.loadLists()
        XCTAssertTrue(presenter.lists.count == 1)
    }
    
    func testGetList_whenGetListIsCalled_shouldRouterNavigate() {
        sut.loadLists()
        sut.getListAt(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(router.isPushedToTasksList)
        XCTAssertTrue(router.selectedTaskList.id == "12345-67890")
    }

    func testDeleteList_whenListIsDeleted_shouldBeZeroLists() {
        sut.loadLists()
        sut.deleteListAt(indexPath: IndexPath(row: 0, section: 0))
        sut.loadLists()
        XCTAssertTrue(presenter.lists.count == 0)
    }
}
