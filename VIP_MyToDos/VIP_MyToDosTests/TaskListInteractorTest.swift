//
//  TaskListInteractorTest.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class TaskListInteractorTests: XCTestCase {
    
    private var sut: TaskListInteractor!
    private var presenter: MockTaskListPresenter!
    private var mockTaskListService: MockTaskListService!
    private var mockTaskService: MockTaskService!
    var taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    let task = TaskModel(id: "12345-67890",
                         title: "Test Task",
                         icon: "test.icon",
                         done: true,
                         createdAt: Date())
    
    override func setUpWithError() throws {
        super.setUp()
        presenter = MockTaskListPresenter()
        taskList.tasks = [task]
        mockTaskListService = MockTaskListService(lists: [taskList])
        mockTaskService = MockTaskService(list: taskList)
        let homeInteractor = HomeInteractor(tasksListService: mockTaskListService)
        sut = TaskListInteractor(tasksList: taskList,
                                 taskService: mockTaskService,
                                 tasksListService: mockTaskListService,
                                 delegate: homeInteractor)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func testNavigateBack_whenNavigateBackIsCalled_shouldNavigateToHome() {
        sut.navigateBack()
        XCTAssertTrue(presenter.navigateToHome)
    }
    
    func testFetchTask_whenFetchTasks_souldBeOneTask() {
        sut.fetchTasks(request: TaskListModel.FetchTasks.Request())
        XCTAssertEqual(presenter.fetchedTasks.count, 1)
    }
    
    func testAddTask_whenAddTaskIsCalled_souldPresentAddTask() {
        sut.addTask(request: TaskListModel.AddTask.Request())
        XCTAssertEqual(presenter.taskList, taskList)
    }
    
    func testRemoveTask_whenATaskIsRemoved_souldBeNoTasks() {
        let request = TaskListModel.RemoveTask.Request(index: IndexPath(row: 0, section: 0))
        sut.fetchTasks(request: TaskListModel.FetchTasks.Request())
        sut.removeTask(request: request)
        XCTAssertTrue(presenter.removedTasks.isEmpty)
    }
    
    func testUpdateTask_whenATaskIsUpdated_souldTAskShouldBeDone() {
        let request = TaskListModel.UpdateTask.Request(task: task)
        sut.fetchTasks(request: TaskListModel.FetchTasks.Request())
        sut.updateTask(request: request)
        XCTAssertTrue(presenter.updatedTasks.first?.done ?? false)
    }
}

final class MockTaskListPresenter: TaskListPresenterInput {
    
    private(set) var navigateToHome: Bool = false
    private(set) var showAddTask: Bool = false
    private(set) var fetchedTasks: [TaskModel] = [TaskModel]()
    private(set) var removedTasks: [TaskModel] = [TaskModel]()
    private(set) var updatedTasks: [TaskModel] = [TaskModel]()
    private(set) var taskList: TasksListModel = TasksListModel()
    private let task = TaskModel(id: "12345-67890",
                                 title: "Test Task",
                                 icon: "test.icon",
                                 done: false,
                                 createdAt: Date())
    
    func navigateBack() {
        navigateToHome = true
    }
    
    func showAddTask(response: TaskListModel.AddTask.Response) {
        showAddTask = true
        taskList = response.taskList
    }
    
    func presentTasks(response: TaskListModel.FetchTasks.Response) {
        fetchedTasks = response.tasks
    }
    
    func removedTask(response: TaskListModel.RemoveTask.Response) {
        removedTasks = [task]
        removedTasks = response.tasks
    }
    
    func updatedTask(response: TaskListModel.UpdateTask.Response) {
        updatedTasks = [task]
        updatedTasks = response.tasks
    }
}
