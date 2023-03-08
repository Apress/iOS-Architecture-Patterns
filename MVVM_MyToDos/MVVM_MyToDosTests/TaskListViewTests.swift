//
//  TaskListViewTests.swift
//  MVVM_MyToDosTests
//
//  Created by Raúl Ferrer on 16/7/22.
//

import XCTest

@testable import MVVM_MyToDos

class TaskListViewTests: XCTestCase {

    var sut: TaskListView!
    
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let taskService = TaskService(coreDataManager: InMemoryCoreDataManager.shared)
    var taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [],
                                  createdAt: Date())
    
    override func setUpWithError() throws {
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        let viewModel = TaskListViewModel(tasksListModel: taskList, taskService: taskService, tasksListService: tasksListService)
        sut = TaskListView(viewModel: viewModel)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.addTaskButton)
        XCTAssertNotNil(sut.emptyState)
        XCTAssertNotNil(sut.tableView)
    }
    
    func testEmptyState_whenModelHasZeroList_shouldBeEmptyState() {
        XCTAssertFalse(sut.emptyState.isHidden)
    }
    
    func testTableView_whenModelHasAList_shouldNotBeEmptyState() {
        addTaskToDataBase()
        XCTAssertTrue(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasATask_shouldBeOneRow() {
        addTaskToDataBase()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableView_whenModelHasATask_shoulBeACellAtIndexPath() {
        addTaskToDataBase()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testTableView_whenTaskIsDeleted_shouldBeNoneOnModel() {
        addTaskToDataBase()
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertTrue(taskService.fetchTasksForList(taskList).isEmpty)
    }
}

extension TaskListViewTests {
    
    func addTaskToDataBase() {
        tasksListService.saveTasksList(taskList)
        let task = TaskModel(id: "67890-12345",
                         title: "Test Task",
                         icon: "test.icon",
                         done: true,
                         createdAt: Date())
        taskService.saveTask(task, in: taskList)
        let viewModel = TaskListViewModel(tasksListModel: taskList, taskService: taskService, tasksListService: tasksListService)
        sut = TaskListView(viewModel: viewModel)
    }
}
