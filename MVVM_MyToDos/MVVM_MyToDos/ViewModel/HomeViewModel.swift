//
//  HomeViewModel.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class HomeViewModel {
    
    var output: Output!
    var input: Input!
    
    struct Input {
        let reload: PublishRelay<Void>
        let deleteRow: PublishRelay<IndexPath>
        let selectRow: PublishRelay<IndexPath>
    }
    
    struct Output {
        let hideEmptyState: Driver<Bool>
        let lists: Driver<[TasksListModel]>
        let selectedList: Driver<TasksListModel>
    }
    
    private let lists = BehaviorRelay<[TasksListModel]>(value: [])
    private let taskList = BehaviorRelay<TasksListModel>(value: TasksListModel())

    private var tasksListService: TasksListServiceProtocol!
    
    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
        // Inputs
        let reload = PublishRelay<Void>()
        _ = reload.subscribe(onNext: { [self] _ in
            fetchTasksLists()
        })
        let deleteRow = PublishRelay<IndexPath>()
        _ = deleteRow.subscribe(onNext: { [self] indexPath in
            tasksListService.deleteList(listAtIndexPath(indexPath))
        })
        let selectRow = PublishRelay<IndexPath>()
        _ = selectRow.subscribe(onNext: { [self] indexPath in
            taskList.accept(listAtIndexPath(indexPath))
        })
        self.input = Input(reload: reload, deleteRow: deleteRow, selectRow: selectRow)
        
        // Outputs
        let items = lists
            .asDriver(onErrorJustReturn: [])
        let hideEmptyState = lists
            .map({ items in
                return !items.isEmpty
            })
            .asDriver(onErrorJustReturn: false)
        let selectedList = taskList.asDriver()
        output = Output(hideEmptyState: hideEmptyState, lists: items, selectedList: selectedList)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasksLists()
    }
    
    func fetchTasksLists() {
        lists.accept(tasksListService.fetchLists())
    }
    
    func listAtIndexPath(_ indexPath: IndexPath) -> TasksListModel {
        lists.value[indexPath.row]
    }
}
