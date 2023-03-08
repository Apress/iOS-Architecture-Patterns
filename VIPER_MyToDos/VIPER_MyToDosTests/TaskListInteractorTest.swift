//
//  TaskListInteractorTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class TaskListInteractorTest: XCTestCase {
    
    var sut: PresenterToInteractorTaskListProtocol!
    var presenter: TaskListPresenter!
    var router: MockTaskListRouter!
    var view: TaskListViewController!

    override func setUpWithError() throws {
        let task = TaskModel(id: "12345-67890",
                             title: "Test Task",
                             icon: "test.icon",
                             done: false,
                             createdAt: Date())
        let taskList = TasksListModel(id: "12345-67890",
                                      title: "Test List",
                                      icon: "test.icon",
                                      tasks: [task],
                                      createdAt: Date())
        let mockTaskService = MockTaskService(list: taskList)
        sut = TaskListInteractor(taskList: taskList, taskService: mockTaskService)
        presenter = TaskListPresenter()
        router = MockTaskListRouter()
        view = TaskListViewController()
        presenter.router = router
        presenter.view = view
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testLoadTasks_whenLoadTasks_shouldBeOneTasks() {
        sut.loadTasks()
        XCTAssertTrue(presenter.tasks.count == 1)
    }
    
    func testDeleteTask_whenTaskIsDeleted_shouldBeZeroTasks() {
        sut.loadTasks()
        sut.deleteTaskAt(indexPath: IndexPath(row: 0, section: 0))
        sut.loadTasks()
        XCTAssertTrue(presenter.tasks.count == 0)
    }
    
    func testUpdateTask_whenTaskIsUpdated_shouldBeTaskDone() {
        sut.loadTasks()
        let updatedTask = TaskModel(id: "12345-67890",
                                title: "Test Task",
                                icon: "test.icon",
                                done: true,
                                createdAt: Date())
        sut.updateTask(task: updatedTask)
        sut.loadTasks()
        XCTAssertTrue(presenter.tasks.first?.done ?? false)
    }
    
    func testAddTask_whenAddTaskIsCalled_shouldPresentAddTask() {
        sut.addTask()
        XCTAssertTrue(router.isPresentAddTAsk)
        XCTAssertEqual(router.selectedTaskList.id, "12345-67890")
    }
}
