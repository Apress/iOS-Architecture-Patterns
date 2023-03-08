//
//  TaskListViewController.swift
//  VIP_MyToDos
//

import UIKit

protocol SelectedListDelegate: AnyObject {
    func updateLists()
}

protocol TaskListViewControllerInput: AnyObject {
    func navigateToHome()
    func showAddTaskView(viewModel: TaskListModel.AddTask.ViewModel)
    func presentLoadedTasks(viewModel: TaskListModel.FetchTasks.ViewModel)
    func presentRemainingTasks(viewModel: TaskListModel.RemoveTask.ViewModel)
    func presentUpdatedTasks(viewModel: TaskListModel.UpdateTask.ViewModel)
}

protocol TaskListViewControllerOutput: AnyObject {
    func navigateBack()
    func addTask(request: TaskListModel.AddTask.Request)
    func fetchTasks(request: TaskListModel.FetchTasks.Request)
    func removeTask(request: TaskListModel.RemoveTask.Request)
    func updateTask(request: TaskListModel.UpdateTask.Request)
}

final class TaskListViewController: UIViewController {
    var interactor: TaskListInteractorInput?
    var router: TaskListRouterDelegate?
    
    private let taskListView: TaskListView
    
    init(taskListView: TaskListView) {
        self.taskListView = taskListView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskListView.delegate = self
        self.view = taskListView
        fetchTasks()
    }
    
    private func fetchTasks() {
        let request = TaskListModel.FetchTasks.Request()
        interactor?.fetchTasks(request: request)
    }
}

extension TaskListViewController: TaskListViewControllerInput {
    
    func navigateToHome() {
        router?.navigateBack()
    }
    
    func showAddTaskView(viewModel: TaskListModel.AddTask.ViewModel) {
        router?.showAddTaskView(delegate: viewModel.addTaskDelegate, tasksList: viewModel.taskList)
    }
    
    func presentLoadedTasks(viewModel: TaskListModel.FetchTasks.ViewModel) {
        taskListView.show(tasks: viewModel.tasks)
    }
    
    func presentRemainingTasks(viewModel: TaskListModel.RemoveTask.ViewModel) {
        taskListView.show(tasks: viewModel.tasks)
    }
    
    func presentUpdatedTasks(viewModel: TaskListModel.UpdateTask.ViewModel) {
        taskListView.show(tasks: viewModel.tasks)
    }
}

extension TaskListViewController: TaskListViewDelegate {
    
    func navigateBack() {
        interactor?.navigateBack()
    }
    
    func addTask() {
        let request = TaskListModel.AddTask.Request()
        interactor?.addTask(request: request)
    }
    
    func deleteTaskAt(indexPath: IndexPath) {
        let request = TaskListModel.RemoveTask.Request(index: indexPath)
        interactor?.removeTask(request: request)
    }
    
    func updateTask(_ task: TaskModel) {
        let request = TaskListModel.UpdateTask.Request(task: task)
        interactor?.updateTask(request: request)
    }
}
