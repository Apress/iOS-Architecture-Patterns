//
//  TaskListViewTest.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 1/6/22.
//

import XCTest

@testable import MVP_MyToDos

class TaskListViewTest: XCTestCase {
    
    var sut: TaskListView!
    var presenter: TasksListPresenter!
    var task: TaskModel!
    var taskList: TasksListModel!
    
    override func setUpWithError() throws {
        task = TaskModel(id: "67890-12345",
                         title: "Test Task",
                         icon: "test.icon",
                         done: true,
                         createdAt: Date())
        taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [task],
                                  createdAt: Date())
        sut = TaskListView()
        let mockTaskListService = MockTaskListService(lists: [taskList])
        let mockTaskService = MockTaskService(list: taskList)
        presenter = TasksListPresenter(taskListView: sut,
                                       tasksListModel: taskList,
                                       taskService: mockTaskService,
                                       tasksListService: mockTaskListService)
        sut.presenter = presenter
        presenter.fetchTasks()
        sut.reloadData()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiated_shouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.addTaskButton)
        XCTAssertNotNil(sut.emptyState)
        XCTAssertNotNil(sut.tableView)
    }


    func testButtonAction_whenAddTaskButtonIsTapped_shouldBeCalledAddTaskAction() {
        let addTaskButton = sut.addTaskButton
        XCTAssertNotNil(addTaskButton, "UIButton does not exists")
        
        guard let addListButtonAction = addTaskButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(addListButtonAction.contains("addTaskAction"))
    }
    
    func testButtonAction_whenBackButtonIsTapped_shouldBeCalledBackAction() {
        let backButton = sut.backButton
        XCTAssertNotNil(backButton, "UIButton does not exists")
        
        guard let backButtonAction = backButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Not actions assigned for .touchUpInside")
            return
        }

        XCTAssertTrue(backButtonAction.contains("backAction"))
    }
    
    func testEmptyState_whenModelHasZeroTask_shoulBeEmptyState() {
        taskList.tasks = [TaskModel]()
        let mockTaskListService = MockTaskListService(lists: [taskList])
        let mockTaskService = MockTaskService(list: taskList)
        presenter = TasksListPresenter(taskListView: sut,
                                       tasksListModel: taskList,
                                       taskService: mockTaskService,
                                       tasksListService: mockTaskListService)
        sut.presenter = presenter
        presenter.fetchTasks()
        sut.reloadData()
        XCTAssertFalse(sut.emptyState.isHidden)
    }
    
    func testEmptyState_whenModelHasATask_shoulBeNoEmptyState() {
        XCTAssertTrue(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasATask_shouldBeOneRow() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableView_whenModelHasATask_shoulBeACellAtIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testTableView_whenTaskIsDeleted_shouldBeNoneOnModel() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertEqual(sut.presenter.numberOfTasks, 0)
    }
}
