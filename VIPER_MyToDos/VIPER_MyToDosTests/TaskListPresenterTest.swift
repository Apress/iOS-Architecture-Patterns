//
//  TaskListPresenterTest.swift
//  VIPER_MyToDosTests
//
//  Created by Raúl Ferrer on 15/9/22.
//

import XCTest

@testable import VIPER_MyToDos

class TaskListPresenterTest: XCTestCase {

    var sut: TaskListPresenter!
    var view: TaskListViewController!
    var router: MockTaskListRouter!
    var interactor: TaskListInteractor!
    var mockTaskService: MockTaskService!
    
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())
    let task = TaskModel(id: "12345-67890",
                         title: "Test Task",
                         icon: "test.icon",
                         done: false,
                         createdAt: Date())
    
    override func setUpWithError() throws {
        sut = TaskListPresenter()
        mockTaskService = MockTaskService(list: taskList)
        interactor = TaskListInteractor(taskList: taskList,
                                        taskService: mockTaskService)
        interactor.presenter = sut
        view = TaskListViewController()
        view.presenter = sut
        router = MockTaskListRouter()
        sut.interactor = interactor
        sut.view = view
        sut.router = router
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testNumberOfRows_whenAddedOneTask_shouldBeOne() {
        mockTaskService.saveTask(task, in: taskList)
        sut.viewDidLoad()
        XCTAssertTrue(sut.numberOfRowsInSection() == 1)
    }
    
    func testTaskAtIndex_whenAddedOneList_shouldExists() {
        mockTaskService.saveTask(task, in: taskList)
        sut.viewDidLoad()
        XCTAssertNotNil(sut.taskAt(indexPath: IndexPath(row: 0, section: 0)))
    }
    
    func testDeleteRowAtIndex_whenDeleteATask_shouldBeZeroTasks() {
        mockTaskService.saveTask(task, in: taskList)
        sut.viewDidLoad()
        sut.deleteRowAt(indexPath: IndexPath(row: 0, section: 0))
        interactor.loadTasks()
        XCTAssertTrue(sut.tasks.isEmpty)
    }
    
    func testUpdateTask_whenUpdateATask_shouldBeTaskAsDone() {
        mockTaskService.saveTask(task, in: taskList)
        sut.viewDidLoad()
        sut.update(task: task)
        interactor.loadTasks()
        XCTAssertTrue(sut.tasks.first!.done)
    }
    
    func testAddTask_whenAddTaskIsCalled_routerShouldNavigate() {
        sut.addTask()
        XCTAssertTrue(router.isPresentAddTAsk)
    }
}
