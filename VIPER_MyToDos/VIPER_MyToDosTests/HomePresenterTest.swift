//
//  HomePresenterTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 4/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class HomePresenterTest: XCTestCase {
    
    var sut: HomePresenter!
    var view: HomeViewController!
    var router: MockHomeRouter!
    var interactor: HomeInteractor!

    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        sut = HomePresenter()
        let mockTaskListService = MockTaskListService(lists: [taskList])
        interactor = HomeInteractor(tasksListService: mockTaskListService)
        interactor.presenter = sut
        view = HomeViewController()
        view.presenter = sut
        router = MockHomeRouter()
        sut.interactor = interactor
        sut.view = view
        sut.router = router
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    
    func testNumberOfRows_whenAddedOneList_shouldBeOne() {
        sut.viewDidLoad()
        XCTAssertTrue(sut.numberOfRowsInSection() == 1)
    }
    
    func testListAtIndex_whenAddedOneList_shouldExists() {
        sut.viewDidLoad()
        XCTAssertNotNil(sut.listAt(indexPath: IndexPath(row: 0, section: 0)))
    }
    
    func testSelectRowAtIndex_whenAddedOneList_shouldReturnList() {
        sut.viewDidLoad()
        sut.selectRowAt(indexPath: IndexPath(row: 0, section: 0))        
        XCTAssertTrue(router.isPushedToTasksList)
        XCTAssertTrue(router.selectedTaskList.id == "12345-67890")
    }
    
    func testDeleteRowAtIndex_whenDeleteAList_shouldBeZeroLists() {
        sut.viewDidLoad()
        sut.deleteRowAt(indexPath: IndexPath(row: 0, section: 0))
        interactor.loadLists()
        XCTAssertTrue(sut.lists.isEmpty)
    }
    
    func testAddTaskList_whenAddTaskIsCalled_routerShouldNavigate() {
        sut.addTaskList()
        XCTAssertTrue(router.isPushedToAddList)
    }
}
