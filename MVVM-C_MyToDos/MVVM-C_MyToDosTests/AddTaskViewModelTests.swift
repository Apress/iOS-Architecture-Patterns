//
//  AddTaskViewModelTests.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 13/7/22.
//

import XCTest
import RxSwift
import RxTest

@testable import MVVM_C_MyToDos

class AddTaskViewModelTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var viewModel: AddTaskViewModel!
    var testScheduler: TestScheduler!
    
    let taskService = TaskService(coreDataManager: InMemoryCoreDataManager.shared)
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let coordinator = MockAddTaskCoordinator()
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        viewModel = AddTaskViewModel(tasksListModel: taskList,
                                     taskService: taskService, 
                                     coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        viewModel = nil
        testScheduler = nil
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        super.tearDown()
    }
    
    
    func testAddTask_whenAddTaskIsCalled_shouldDismissBeCalled() {
        tasksListService.saveTasksList(taskList)
        testScheduler.createColdObservable([.next(10, "test.icon")])
            .bind(to: viewModel.input.icon)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(20, "test.title")])
            .bind(to: viewModel.input.title)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(30, ())])
            .bind(to: viewModel.input.addTask)
            .disposed(by: disposeBag)
        testScheduler.start()
        
        XCTAssertEqual(viewModel.task.icon, "test.icon")
        XCTAssertEqual(viewModel.task.title, "test.title")
        XCTAssertEqual(coordinator.dismissView, 1)
    }
}
