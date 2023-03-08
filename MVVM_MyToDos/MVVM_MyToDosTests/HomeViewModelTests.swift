//
//  HomeViewModelTests.swift
//  MVVM_MyToDosTests
//
//  Created by Raúl Ferrer on 12/7/22.
//

import XCTest
import RxSwift
import RxTest

@testable import MVVM_MyToDos

class HomeViewModelTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var viewModel: HomeViewModel!
    var testScheduler: TestScheduler!
    
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [TaskModel](),
                                  createdAt: Date())



    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        viewModel = HomeViewModel(tasksListService: tasksListService)
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        viewModel = nil
        testScheduler = nil
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        super.tearDown()
    }


    func testEmptyState_whenThereIsNoList_shouldShowEmptyState() {
        let hideEmptyState = testScheduler.createObserver(Bool.self)

        viewModel.output.hideEmptyState
            .drive(hideEmptyState)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.start()
        
        XCTAssertEqual(hideEmptyState.events, [.next(0, false), .next(10, false)])
    }
    

    func testEmptyState_whenAddOneList_shouldHideEmptyState() {
        let hideEmptyState = testScheduler.createObserver(Bool.self)
        tasksListService.saveTasksList(taskList)
        
        viewModel.output.hideEmptyState
            .drive(hideEmptyState)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.start()
        
        XCTAssertEqual(hideEmptyState.events, [.next(0, false), .next(10, true)])
    }
    
    
    func testRemoveListAtIndex_whenAddedOneList_shouldBeEmptyModelOnDeleteList() {
        let lists = testScheduler.createObserver([TasksListModel].self)
        tasksListService.saveTasksList(taskList)
        
        viewModel.output.lists
            .drive(lists)
            .disposed(by: disposeBag)
    
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(20, IndexPath(row: 0, section: 0))])
            .bind(to: viewModel.input.deleteRow)
            .disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(30, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(lists.events, [.next(0, []), .next(10, [taskList]), .next(30, []), .next(30, [])])
    }
    
    func testSelectListAtIndex_whenSelectAList_shouldBeReturnOneList() {
        let selectedList = testScheduler.createObserver(TasksListModel.self)
        tasksListService.saveTasksList(taskList)
        
        viewModel.output.selectedList
            .drive(selectedList)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(20, IndexPath(row: 0, section: 0))])
            .bind(to: viewModel.input.selectRow)
            .disposed(by: disposeBag)

        testScheduler.start()
        
        XCTAssertEqual(selectedList.events, [.next(0, TasksListModel()), .next(20, taskList)])
    }
}
