//
//  TasksListViewModel.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import RxRelay
import RxCocoa

class TaskListViewModel {
    
    var output: Output!
    var input: Input!
    let coordinator: TaskListCoordinatorProtocol!

    struct Input {
        let reload: PublishRelay<Void>
        let deleteRow: PublishRelay<IndexPath>
        let updateRow: PublishRelay<IndexPath>
        let addTask: PublishRelay<Void>
        let dismiss: PublishRelay<Void>
    }
    
    struct Output {
        let hideEmptyState: Driver<Bool>
        let tasks: Driver<[TaskModel]>
        let pageTitle: Driver<String>
    }
    
    private var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private var tasksListService: TasksListServiceProtocol!
    
    let tasks = BehaviorRelay<[TaskModel]>(value: [])
    let pageTitle = BehaviorRelay<String>(value: "")
    
    init(tasksListModel: TasksListModel,
         taskService: TaskServiceProtocol,
         tasksListService: TasksListServiceProtocol,
         coordinator: TaskListCoordinatorProtocol) {
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.tasksListService = tasksListService
        self.coordinator = coordinator
        
        // Inputs
        let reload = PublishRelay<Void>()
        _ = reload.subscribe(onNext: { [self] _ in
            fetchTasks()
        })
        let deleteRow = PublishRelay<IndexPath>()
        _ = deleteRow.subscribe(onNext: { [self] indexPath in
            deleteTaskAt(indexPath: indexPath)
        })
        let updateRow = PublishRelay<IndexPath>()
        _ = updateRow.subscribe(onNext: { [self] indexPath in
            updateTaskAt(indexPath: indexPath)
        })
        let addTask = PublishRelay<Void>()
        _ = addTask.subscribe(onNext: { _ in
            coordinator.gotoAddTask()
        })
        let dismissView = PublishRelay<Void>()
        _ = dismissView.subscribe(onNext: { _ in
            coordinator.navigateBack()
        })
        input = Input(reload: reload,
                      deleteRow: deleteRow,
                      updateRow: updateRow,
                      addTask: addTask,
                      dismiss: dismissView)
        
        // Outputs
        let items = tasks
            .asDriver(onErrorJustReturn: [])
        let hideEmptyState = tasks
            .map({ items in
                return !items.isEmpty
            })
            .asDriver(onErrorJustReturn: false)
        let pageTitle = pageTitle
            .asDriver(onErrorJustReturn: "")
        output = Output(hideEmptyState: hideEmptyState, tasks: items, pageTitle: pageTitle)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasks()
    }
    
    func fetchTasks() {
        guard let list = tasksListService.fetchListWithId(tasksListModel.id) else { return }
        let orderedTasks = list.tasks.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending })
        tasks.accept(orderedTasks)
        pageTitle.accept(list.title)
    }
    
    func deleteTaskAt(indexPath: IndexPath) {
        taskService.deleteTask(tasks.value[indexPath.row])
    }
    
    func updateTaskAt(indexPath: IndexPath) {
        var taskToUpdate = tasks.value[indexPath.row]
        taskToUpdate.done.toggle()
        taskService.updateTask(taskToUpdate)
    }
}
