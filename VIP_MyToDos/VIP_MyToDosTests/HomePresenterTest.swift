//
//  HomeScenePresenterTests.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class HomePresenterTest: XCTestCase {
    
    private var sut: HomePresenter!
    private var viewController: MockHomeViewController!
    private var router: MockHomeRouter!
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        super.setUp()
        viewController = MockHomeViewController()
        router = MockHomeRouter()
        viewController.router = router
        sut = HomePresenter()
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        router = nil
        super.tearDown()
    }
    
    func testPresentLists_whenShouldPresentList_reloadDataIsCalled() {
        let response = HomeModel.FetchTasksLists.Response(tasksLists: [taskList])
        sut.presentTasksLists(response: response)
        XCTAssertTrue(!viewController.lists.isEmpty)
    }
    
    func testShowAddTaskList_whenAddTaskListIsSelected_shouldNavigateToAddTaskList() {
        let response = HomeModel.AddTasksList.Response(addListDelegate: viewController)
        sut.showAddTaskList(response: response)
        XCTAssertTrue(viewController.showAddList)
        XCTAssertTrue(router.navigateToAddList)
    }
    
    func testShowSelectedList_whenTaskListIsSelected_shouldNavigateToTasksList() {
        let response = HomeModel.SelectTasksList.Response(selectedListDelegate: viewController, tasksList: taskList)
        sut.showSelectedList(response: response)
        XCTAssertEqual(viewController.selectedList.id, taskList.id)
        XCTAssertTrue(router.navigateToTaskList)
        XCTAssertEqual(router.selectedList.id, taskList.id)
    }
}

final class MockHomeViewController: HomeViewControllerInput, AddListDelegate, SelectedListDelegate {

    var router: HomeRouterDelegate?
    
    private(set) var lists: [TasksListModel] = [TasksListModel]()
    private(set) var selectedList: TasksListModel = TasksListModel()
    private(set) var showAddList: Bool = false

    func reloadDataWithTaskList(viewModel: HomeModel.FetchTasksLists.ViewModel) {
        lists = viewModel.tasksLists
    }
    
    func showAddListView(viewModel: HomeModel.AddTasksList.ViewModel) {
        showAddList = true
        router?.showAddListView(delegate: self)
    }
    
    func showSelectedList(viewModel: HomeModel.SelectTasksList.ViewModel) {
        selectedList = viewModel.tasksList
        router?.showSelectedList(delegate: self, list: viewModel.tasksList)
    }
    
    func didAddList() {}
    
    func updateLists() {}
}
