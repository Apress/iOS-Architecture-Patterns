//
//  HomeViewTests.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 16/7/22.
//

import XCTest

@testable import MVVM_C_MyToDos

class HomeViewTest: XCTestCase {
    
    var sut: HomeView!
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let mockHomeCoordinator = MockHomeCoordinator()

    override func setUpWithError() throws {
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        let viewModel = HomeViewModel(tasksListService: tasksListService, coordinator: mockHomeCoordinator)
        sut = HomeView(viewModel: viewModel)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.addListButton)
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.emptyState)
    }
    
    func testEmptyState_whenModelHasZeroList_shouldBeEmptyState() {
        XCTAssertFalse(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasAList_shouldNotBeEmptyState() {
        addListToDataBase()
        XCTAssertTrue(sut.emptyState.isHidden)
    }
    
    func testTableView_whenModelHasAList_shouldBeOneRow() {
        addListToDataBase()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableView_whenModelHasAList_shoulBeACellAtIndexPath() {
        addListToDataBase()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testTableView_whenListIsDeleted_shouldBeNoneOnModel() {
        addListToDataBase()
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertTrue(tasksListService.fetchLists().isEmpty)
    }
}

extension HomeViewTest {
    
    func addListToDataBase() {
        let taskList = TasksListModel(id: "12345-67890",
                                      title: "Test List",
                                      icon: "test.icon",
                                      tasks: [TaskModel](),
                                      createdAt: Date())
        tasksListService.saveTasksList(taskList)
        let viewModel = HomeViewModel(tasksListService: tasksListService, coordinator: mockHomeCoordinator)
        sut = HomeView(viewModel: viewModel)
    }
}
