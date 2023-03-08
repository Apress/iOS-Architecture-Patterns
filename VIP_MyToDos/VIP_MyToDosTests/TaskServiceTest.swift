//
//  TaskServiceTest.swift
//  VIP_MyToDosTests
//
//  Created by Raúl Ferrer on 14/9/22.
//

import XCTest
import CoreData

@testable import VIP_MyToDos

class TaskServiceTest: XCTestCase {
    
    var sut: TaskServiceProtocol!
    var taskListService: TasksListServiceProtocol!
    var list: TasksListModel!
    var task: TaskModel!
    
    override func setUpWithError() throws {
        let inMemoryCoreDataManager = InMemoryCoreDataManager()
        sut = TaskService(coreDataManager: inMemoryCoreDataManager)
        taskListService = TasksListService(coreDataManager: inMemoryCoreDataManager)
        list = TasksListModel(id: "12345-67890",
                              title: "Test List",
                              icon: "test.icon",
                              tasks: [TaskModel](),
                              createdAt: Date())
        task = TaskModel(id: "12345-67890",
                         title: "Test Task",
                         icon: "test.icon",
                         done: false,
                         createdAt: Date())
        taskListService.saveTasksList(list)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        list = nil
        task = nil
        taskListService = nil
        super.tearDown()
    }
    
    func testSaveOnDB_whenSavesATask_shouldBeOneOnDatabase() {
        sut.saveTask(task, in: list)
        XCTAssertEqual(sut.fetchTasksForList(list).count, 1)
    }
    
    func testUpdateOnDB_whenSavesATaskAndThenUpdated_shouldBeUpdatedOnDatabase() {
        sut.saveTask(task, in: list)
        task.done = true
        sut.updateTask(task)
        XCTAssertEqual(sut.fetchTasksForList(list).first?.done, true)
    }
    
    func testDeleteOnDB_whenSavesATaskAndThenDeleted_shouldBeNoneOnDatabase() {
        sut.saveTask(task, in: list)
        XCTAssertEqual(sut.fetchTasksForList(list).count, 1)
        sut.deleteTask(task)
        XCTAssertEqual(sut.fetchTasksForList(list).count, 0)
    }
}
