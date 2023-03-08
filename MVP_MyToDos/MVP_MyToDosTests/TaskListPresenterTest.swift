//
//  TaskListPresenterTest.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 31/5/22.
//

import XCTest

@testable import MVP_MyToDos

class TaskListPresenterTest: XCTestCase {
    
    var sut: TasksListPresenter!
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
        let mockTaskListService = MockTaskListService(lists: [taskList])
        let mockTaskService = MockTaskService(list: taskList)
        sut = TasksListPresenter(tasksListModel: taskList,
                                 taskService: mockTaskService,
                                 tasksListService: mockTaskListService)
        sut.fetchTasks()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testPageTitle_whenModelHasTitle_shouldBePageTitle() {
        XCTAssertEqual(sut.pageTitle, "Test List")
    }
        
    
    func testNumberOfTasks_whenModelHasOneTask_shouldBeOneNumberOfTasks() {
        XCTAssertEqual(sut.numberOfTasks, 1)
    }
    
    func testTaskAtIndex_whenModelHasOneTask_shouldReturnOneTaskAtIndexZero() {
        XCTAssertNotNil(sut.taskAtIndex(0))
    }
   
    func testRemoveTaskAtIndex_whenModelHasOneTask_shouldBeEmptyModelOnDeleteTask() {
        sut.removeTaskAtIndex(0)
        XCTAssertEqual(sut.numberOfTasks, 0)
    }
}
