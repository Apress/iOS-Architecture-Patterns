//
//  HomeInteractorTest.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class HomeInteractorTest: XCTestCase {
    
    private var sut: HomeInteractor!
    private var presenter: MockHomePresenter!
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        super.setUp()
        let mockTaskListService = MockTaskListService(lists: [taskList])
        presenter = MockHomePresenter()
        sut = HomeInteractor(tasksListService: mockTaskListService)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        
        super.tearDown()
    }
    
    func testPresentList_whenPresentLists_shouldBeOneList() {
        let request = HomeModel.FetchTasksLists.Request()
        sut.fetchTasksLists(request: request)
        XCTAssertEqual(presenter.taskLists.count, 1)
    }
    
    func testAddList_whenAddListSelected_shouldShowAddList() {
        let request = HomeModel.AddTasksList.Request()
        sut.addList(request: request)
        XCTAssertTrue(presenter.showAddList)
    }
    
    func testSelectList_whenListIsSelected_shouldBeList() {
        let request = HomeModel.SelectTasksList.Request(index: IndexPath(row: 0, section: 0))
        sut.fetchTasksLists()
        sut.selectList(request: request)
        XCTAssertEqual(presenter.selectedList.id, taskList.id)
    }
    
    func testRemoveList_whenListIsRemoved_shouldBeNoLists() {
        let request = HomeModel.RemoveTasksList.Request(index: IndexPath(row: 0, section: 0))
        sut.fetchTasksLists()
        sut.removeList(request: request)
        XCTAssertTrue(presenter.taskLists.isEmpty)
    }
}

final class MockHomePresenter: HomePresenterInput {
    
    private(set) var taskLists: [TasksListModel] = [TasksListModel]()
    private(set) var showAddList: Bool = false
    private(set) var selectedList: TasksListModel = TasksListModel()
    
    func presentTasksLists(response: HomeModel.FetchTasksLists.Response) {
        taskLists = response.tasksLists
    }
    
    func showAddTaskList(response: HomeModel.AddTasksList.Response) {
        showAddList = true
    }
    
    func showSelectedList(response: HomeModel.SelectTasksList.Response) {
        selectedList = response.tasksList
    }
}
