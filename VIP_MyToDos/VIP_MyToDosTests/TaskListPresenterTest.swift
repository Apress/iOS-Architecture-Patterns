//
//  TaskListScenePresenterTests.swift
//  VIP_MyToDos
//

import XCTest
@testable import VIP_MyToDos

final class TaskListPresenterTests: XCTestCase {
    
    private var sut: TaskListPresenter!
    private var viewController: MockTaskListViewController!
    private var router: MockTaskListRouter!
    let taskList = TasksListModel(id: "12345-67890",
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
        viewController = MockTaskListViewController()
        router = MockTaskListRouter()
        viewController.router = router
        sut = TaskListPresenter()
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        router = nil
        super.tearDown()
    }
    
    func testNavigateBack_whenNavigateBackIsCalled_shouldNavigateToHome() {
        sut.navigateBack()
        XCTAssertTrue(viewController.navigateBack)
    }
    
    func testFetchTask_whenFetchTasks_souldBeOneTask() {
        let response = TaskListModel.FetchTasks.Response(tasks: [task])
        sut.presentTasks(response: response)
        XCTAssertEqual(viewController.listTasks.count, 1)
    }
    
    func testAddTask_whenAddTaskIsCalled_souldPresentAddTask() {
        let taskListInteractor = MockTaskListInteractor()
        let response = TaskListModel.AddTask.Response(addTaskDelegate: taskListInteractor,
                                                      taskList: taskList)
        sut.showAddTask(response: response)
        XCTAssertTrue(viewController.presentAddList)
        XCTAssertEqual(viewController.selectedList.id, taskList.id)
    }
    
    func testRemoveTask_whenATaskIsRemoved_souldBeNoTasks() {
        let response = TaskListModel.RemoveTask.Response(tasks: [TaskModel]())
        sut.removedTask(response: response)
        XCTAssertTrue(viewController.listTasks.isEmpty)
    }
    
    func testUpdateTask_whenATaskIsUpdated_souldTAskShouldBeDone() {
        let response = TaskListModel.UpdateTask.Response(tasks: [task])
        sut.updatedTask(response: response)
        XCTAssertTrue(viewController.listTasks.first?.done ?? false)
    }
}

final class MockTaskListViewController: TaskListViewControllerInput {
    
    var router: TaskListRouterDelegate?
    
    private(set) var navigateBack: Bool = false
    private(set) var presentAddList: Bool = false
    private(set) var selectedList: TasksListModel = TasksListModel()
    private(set) var listTasks: [TaskModel] = [TaskModel]()

    func navigateToHome() {
        navigateBack = true
        router?.navigateBack()
    }
    
    func showAddTaskView(viewModel: TaskListModel.AddTask.ViewModel) {
        presentAddList = true
        selectedList = viewModel.taskList
        let taskListInteractor = MockTaskListInteractor()
        router?.showAddTaskView(delegate: taskListInteractor,
                                tasksList:  viewModel.taskList)
    }
    
    func presentLoadedTasks(viewModel: TaskListModel.FetchTasks.ViewModel) {
        listTasks = viewModel.tasks
    }
    
    func presentRemainingTasks(viewModel: TaskListModel.RemoveTask.ViewModel) {
        listTasks = viewModel.tasks
    }
    
    func presentUpdatedTasks(viewModel: TaskListModel.UpdateTask.ViewModel) {
        let task = TaskModel(id: "12345-67890",
                             title: "Test Task",
                             icon: "test.icon",
                             done: true,
                             createdAt: Date())
        listTasks = [task]
        listTasks = viewModel.tasks
    }
}
