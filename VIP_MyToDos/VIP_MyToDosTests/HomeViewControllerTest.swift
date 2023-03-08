//
//  HomeViewControllerTest.swift
//  VIP_MyToDosTests
//
//  Created by Raúl Ferrer on 7/10/22.
//

import XCTest
@testable import VIP_MyToDos

final class HomeViewControllerTest: XCTestCase {

    private var sut: HomeViewController!
    private var interactor: MockHomeInteractor!
    private var router: MockHomeRouter!
    private var view: HomeView!
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        super.setUp()
        interactor = MockHomeInteractor()
        router = MockHomeRouter()
        view = HomeView()
        sut = HomeViewController(homeView: view)
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
    
    func testAddList_whenAddListIsSelected_shoulCallAddList() {
        sut.addList()
        XCTAssertTrue(interactor.addListRequest)
        let viewModel = HomeModel.AddTasksList.ViewModel(addListDelegate: interactor)
        sut.showAddListView(viewModel: viewModel)
        XCTAssertTrue(router.navigateToAddList)
    }
    
    func testSelectedList_whenAddListIsSelected_shouldCallTasksList() {
        sut.selectedListAt(index: IndexPath(row: 1, section: 1))
        XCTAssertEqual(interactor.selectTasksListIndex.row, 1)
        XCTAssertEqual(interactor.selectTasksListIndex.section, 1)
        let viewModel = HomeModel.SelectTasksList.ViewModel(selectedListDelegate: interactor, tasksList: taskList)
        sut.showSelectedList(viewModel: viewModel)
        XCTAssertTrue(router.navigateToTaskList)
        XCTAssertEqual(router.selectedList.id, taskList.id)
    }
    
    func testDeleteList_whenAListIsDelete_shouldBeNoLists() {
        sut.deleteListAt(indexPath: IndexPath(row: 1, section: 1))
        XCTAssertEqual(interactor.deleteTasksListIndex.row, 1)
        XCTAssertEqual(interactor.deleteTasksListIndex.section, 1)
    }
}

final class MockHomeInteractor: HomeInteractorInput, AddListDelegate, SelectedListDelegate {
     
    private(set) var addListRequest: Bool = false
    private(set) var fetchTasksListRequest: Bool = false
    private(set) var selectTasksListIndex: IndexPath = IndexPath(row: 0, section: 0)
    private(set) var deleteTasksListIndex: IndexPath = IndexPath(row: 0, section: 0)


    func fetchTasksLists(request: HomeModel.FetchTasksLists.Request) {
        fetchTasksListRequest = true
    }

    func addList(request: HomeModel.AddTasksList.Request) {
        addListRequest = true
    }

    func selectList(request: HomeModel.SelectTasksList.Request) {
        selectTasksListIndex = request.index
    }

    func removeList(request: HomeModel.RemoveTasksList.Request) {
        deleteTasksListIndex = request.index
    }
    
    func didAddList() {}
    
    func updateLists() {}
}

final class MockHomeRouter: HomeRouterDelegate {
    
    private(set) var navigateToAddList: Bool = false
    private(set) var navigateToTaskList: Bool = false
    private(set) var selectedList: TasksListModel = TasksListModel()
    
    func showAddListView(delegate: AddListDelegate) {
        navigateToAddList = true
    }
    
    func showSelectedList(delegate: SelectedListDelegate, list: TasksListModel) {
        navigateToTaskList = true
        selectedList = list
    }
}
