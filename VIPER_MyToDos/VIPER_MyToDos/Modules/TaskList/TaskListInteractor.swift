//
//  TaskListInteractor.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class TaskListInteractor: PresenterToInteractorTaskListProtocol {
    
    var presenter: InteractorToPresenterTaskListProtocol?
    var tasks: [TaskModel] = [TaskModel]()
    var taskList: TasksListModel!
    var taskService: TaskServiceProtocol!

    init(taskList: TasksListModel, taskService: TaskServiceProtocol) {
        self.taskList = taskList
        self.taskService = taskService
    }
    
    func loadTasks() {
        tasks = (taskService?.fetchTasksForList(taskList))!
        presenter?.fetchedTasks(tasks: tasks)
    }
    
    func deleteTaskAt(indexPath: IndexPath) {
        guard tasks.indices.contains(indexPath.row) else { return }
        taskService.deleteTask(tasks[indexPath.row])
    }
    
    func updateTask(task: TaskModel) {
        taskService.updateTask(task)
    }
    
    func addTask() {
        presenter?.addTaskTo(list: taskList)
    }
}
