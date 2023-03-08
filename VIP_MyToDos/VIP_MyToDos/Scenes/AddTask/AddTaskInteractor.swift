//
//  AddTaskInteractor.swift
//  VIP_MyToDos
//

import Foundation

protocol AddTaskInteractorOutput: AnyObject {
    func dismissView()
}

typealias AddTaskInteractorInput = AddTaskViewControllerOutput

final class AddTaskInteractor {
    var presenter: AddTaskPresenterInput?
    
    private var tasksList: TasksListModel!
    private var taskService: TaskServiceProtocol!
    
    weak var delegate: AddTaskDelegate?
    
    init(tasksList: TasksListModel,
         taskService: TaskServiceProtocol,
         delegate: AddTaskDelegate) {
        self.tasksList = tasksList
        self.taskService = taskService
        self.delegate = delegate
    }
}

extension AddTaskInteractor: AddTaskInteractorInput {
    
    func addTask(request: AddTaskModel.AddTask.Request) {
        let task = TaskModel(id: ProcessInfo().globallyUniqueString,
                             title: request.title,
                             icon: request.icon,
                             done: false,
                             createdAt: Date())
        taskService.saveTask(task, in: tasksList)
        delegate?.didAddTask()
        presenter?.dismissView()
    }
}
