//
//  AddListViewModelTests.swift
//  MVVM_MyToDosTests
//
//  Created by Raúl Ferrer on 13/7/22.
//

import XCTest
import RxSwift
import RxTest

@testable import MVVM_MyToDos

class AddListViewModelTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var viewModel: AddListViewModel!
    var testScheduler: TestScheduler!
    
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        viewModel = AddListViewModel(tasksListService: tasksListService)
    }
    
    override func tearDownWithError() throws {
        disposeBag = nil
        viewModel = nil
        testScheduler = nil
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        super.tearDown()
    }
    
    func testAddList_whenAddListIsCalled_shouldDismissBeCalled() {
        let dismiss = testScheduler.createObserver(Bool.self)
        
        viewModel.output.dismiss
            .map { true }
            .drive(dismiss)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(10, "test.icon")])
            .bind(to: viewModel.input.icon)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(20, "test.title")])
            .bind(to: viewModel.input.title)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(30, ())])
            .bind(to: viewModel.input.addList)
            .disposed(by: disposeBag)
        testScheduler.start()
        
        XCTAssertEqual(viewModel.list.icon, "test.icon")
        XCTAssertEqual(viewModel.list.title, "test.title")
        XCTAssertEqual(dismiss.events, [.next(0, true), .next(30, true)])
    }
}
