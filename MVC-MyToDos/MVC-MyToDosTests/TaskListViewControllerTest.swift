//
//  TaskListViewControllerTest.swift
//  MVC-MyToDosTests
//
//  Created by Raúl Ferrer on 15/5/22.
//

import XCTest

@testable import MVC_MyToDos

class TaskListViewControllerTest: XCTestCase {
    
    var sut: TaskListViewController!
    var navigationController: MockNavigationController!
    var tasksListService: MockTaskListService!
    var taskService: MockTaskService!
    let list = TasksListModel(id: ProcessInfo().globallyUniqueString,
                              title: "Test title",
                              icon: "test.icon",
                              tasks: [TaskModel](),
                              createdAt: Date())
    let task = TaskModel(id: ProcessInfo().globallyUniqueString,
                         title: "Task",
                         icon: "test.icon",
                         done: true,
                         createdAt: Date())

    override func setUpWithError() throws {
        tasksListService = MockTaskListService(lists: [list])
        taskService = MockTaskService(list: list)
        sut = TaskListViewController(tasksListModel: list, taskService: taskService, tasksListService: tasksListService)
        navigationController = MockNavigationController(rootViewController: UIViewController())
        navigationController.pushViewController(sut, animated: false)
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        tasksListService = nil
        taskService = nil
        super.tearDown()
    }

    func testAddTask_whenAddedATask_shouldBeOneOnDatabase() {
        taskService.saveTask(task, in: list)
        XCTAssertEqual(taskService.fetchTasksForList(list).count, 1)
    }
    
    func testUpdateTask_whenUpdatedATask_shouldBeUpdatedOnDatabase() {
        taskService.saveTask(task, in: list)
        var updatedTask = task
        updatedTask.done = false
        sut.updateTask(updatedTask)
        guard let fetchedTask = taskService.fetchTasksForList(list).first else {
            XCTFail("Task don't exists")
            return
        }
        XCTAssertFalse(fetchedTask.done!)
    }
    
    func testDeleteTask_whenDeletedATask_shouldBeNoneOnDatabase() {
        taskService.saveTask(task, in: list)
        sut.deleteTask(task)
        XCTAssertEqual(taskService.fetchTasksForList(list).count, 0)
    }
    
    func testPopVC_whenBackActionIsCalled_thenPopHomeCalled() {
        sut.navigateBack()
        XCTAssertTrue(navigationController.vcIsPopped)
    }
}
