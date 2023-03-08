//
//  TaskListViewControllerTest.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class TaskListViewControllerTest: XCTestCase {
    
    private var sut: TaskListViewController!
    private var interactor: MockTaskListInteractor!
    private var router: MockTaskListRouter!
    private var view: TaskListView!
    
    override func setUpWithError() throws {
        super.setUp()
        interactor = MockTaskListInteractor()
        router = MockTaskListRouter()
        view = TaskListView()
        sut = TaskListViewController(taskListView: view)
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
    
    func testNavigateBack_whenCallNavigateToHome_shouldNavigateBack() {
        sut.navigateBack()
        XCTAssertTrue(interactor.navigateBackRequest)
    }
    
    func testAddTask_whenCallAddTask_shouldPresentAddTask() {
        sut.addTask()
        XCTAssertTrue(interactor.addTaskRequest)
    }
    
    func testDeleteTask_whenATaskIsDeleted_shoulBeNoTasks() {
        sut.deleteTaskAt(indexPath: IndexPath(row: 1, section: 1))
        XCTAssertEqual(interactor.deleteTaskIndex.row, 1)
        XCTAssertEqual(interactor.deleteTaskIndex.section, 1)
    }
    
    func testUpdateTask_whenATaskIsUpdated_shoulBeDone() {
        let task = TaskModel(id: "12345-67890",
                             title: "Test Task",
                             icon: "test.icon",
                             done: true,
                             createdAt: Date())
        sut.updateTask(task)
        XCTAssertTrue(interactor.updateTask.done)
    }
}

final class MockTaskListInteractor: TaskListInteractorInput, AddTaskDelegate {
    
    private(set) var navigateBackRequest: Bool = false
    private(set) var fetchTaskRequest: Bool = false
    private(set) var addTaskRequest: Bool = false
    private(set) var deleteTaskIndex: IndexPath = IndexPath(row: 0, section: 0)
    private(set) var updateTask: TaskModel = TaskModel(id: "12345-67890",
                                                       title: "Test Task",
                                                       icon: "test.icon",
                                                       done: false,
                                                       createdAt: Date())

    func navigateBack() {
        navigateBackRequest = true
    }
    
    func addTask(request: TaskListModel.AddTask.Request) {
        addTaskRequest = true
    }
    
    func fetchTasks(request: TaskListModel.FetchTasks.Request) {
        fetchTaskRequest = true
    }
    
    func removeTask(request: TaskListModel.RemoveTask.Request) {
        deleteTaskIndex = request.index
    }
    
    func updateTask(request: TaskListModel.UpdateTask.Request) {
        updateTask = request.task
    }
    
    func didAddTask() {}
}

final class MockTaskListRouter: TaskListRouterDelegate {
    
    private(set) var navigateToHome: Bool = false
    private(set) var presentAddTask: Bool = false
    private(set) var selectedList: TasksListModel = TasksListModel()

    func navigateBack() {
        navigateToHome = true
    }
    
    func showAddTaskView(delegate: AddTaskDelegate, tasksList: TasksListModel) {
        presentAddTask = true
        selectedList = tasksList
    }
}
