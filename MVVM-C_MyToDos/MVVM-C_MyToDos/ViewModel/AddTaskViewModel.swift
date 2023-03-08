//
//  AddTaskViewModel.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import RxRelay
import RxCocoa

class AddTaskViewModel {
    
    var input: Input!
    var coordinator: AddTaskCoordinatorProtocol!
    
    struct Input {
        let icon: PublishRelay<String>
        let title: PublishRelay<String>
        let addTask: PublishRelay<Void>
    }

    private var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private(set) var task: TaskModel!
    
    init(tasksListModel: TasksListModel,
         taskService: TaskServiceProtocol,
         coordinator: AddTaskCoordinatorProtocol) {
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.coordinator = coordinator
        self.task = TaskModel(id: ProcessInfo().globallyUniqueString,
                              icon: "checkmark.seal.fill",
                              done: false,
                              createdAt: Date())
        
        // Inputs
        let icon = PublishRelay<String>()
        _ = icon.subscribe(onNext: { [self] newIcon in
            task.icon = newIcon
        })
        let title = PublishRelay<String>()
        _ = title.subscribe(onNext: { [self] newTitle in
            task.title = newTitle
        })
        let addTask = PublishRelay<Void>()
        _ = addTask.subscribe(onNext: { [self] _ in
            taskService.saveTask(task, in: tasksListModel)
            coordinator.dismiss()
        })
        input = Input(icon: icon, title: title, addTask: addTask)
    }
}
