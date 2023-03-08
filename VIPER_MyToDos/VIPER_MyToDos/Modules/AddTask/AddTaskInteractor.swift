//
//  AddTaskInteractor.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class AddTaskInteractor: PresenterToInteractorAddTaskProtocol {
    
    var presenter: InteractorToPresenterAddTaskProtocol?
    var taskList: TasksListModel!
    var taskService: TaskServiceProtocol!
    
    init(taskList: TasksListModel, taskService: TaskServiceProtocol) {
        self.taskList = taskList
        self.taskService = taskService
    }
    
    func addTask(task: TaskModel) {
        taskService?.saveTask(task, in: taskList)
        presenter?.addedTask()
    }
}
