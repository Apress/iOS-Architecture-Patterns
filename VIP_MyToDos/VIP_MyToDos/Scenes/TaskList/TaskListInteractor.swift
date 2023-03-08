//
//  TaskListInteractor.swift
//  VIP_MyToDos
//

import Foundation

protocol TaskListInteractorOutput: AnyObject {
    func navigateBack()
    func showAddTask(response: TaskListModel.AddTask.Response)
    func presentTasks(response: TaskListModel.FetchTasks.Response)
    func removedTask(response: TaskListModel.RemoveTask.Response)
    func updatedTask(response: TaskListModel.UpdateTask.Response)
}

typealias TaskListInteractorInput = TaskListViewControllerOutput

final class TaskListInteractor {
    
    var presenter: TaskListPresenterInput?
    
    private var tasksList: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private var tasksListService: TasksListServiceProtocol!
    private var tasks = [TaskModel]()
    
    weak var delegate: SelectedListDelegate?

    init(tasksList: TasksListModel,
         taskService: TaskServiceProtocol,
         tasksListService: TasksListServiceProtocol,
         delegate: SelectedListDelegate) {
        self.tasksList = tasksList
        self.taskService = taskService
        self.tasksListService = tasksListService
        self.delegate = delegate
    }
}

extension TaskListInteractor: TaskListInteractorInput {
      
    func navigateBack() {
        presenter?.navigateBack()
    }
    
    func addTask(request: TaskListModel.AddTask.Request) {
        let response = TaskListModel.AddTask.Response(addTaskDelegate: self, taskList: tasksList)
        presenter?.showAddTask(response: response)
    }
    
    func fetchTasks(request: TaskListModel.FetchTasks.Request) {
        guard let list = tasksListService.fetchListWithId(tasksList.id) else { return }
        tasksList = list
        tasks = tasksList.tasks.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending })
        let response = TaskListModel.FetchTasks.Response(tasks: tasks)
        presenter?.presentTasks(response: response)
    }
    
    func removeTask(request: TaskListModel.RemoveTask.Request) {
        let task = tasks[request.index.row]
        taskService.deleteTask(task)
        tasks.remove(at: request.index.row)
        let response = TaskListModel.RemoveTask.Response(tasks: tasks)
        presenter?.removedTask(response: response)
        delegate?.updateLists()
    }
    
    func updateTask(request: TaskListModel.UpdateTask.Request) {
        taskService.updateTask(request.task)
        let response = TaskListModel.UpdateTask.Response(tasks: tasks)
        presenter?.updatedTask(response: response)
        delegate?.updateLists()
    }
}

extension TaskListInteractor: AddTaskDelegate {
    
    func didAddTask() {
        fetchTasks(request: TaskListModel.FetchTasks.Request())
        delegate?.updateLists()
    }
}
