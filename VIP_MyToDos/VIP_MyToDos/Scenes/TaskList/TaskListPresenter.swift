//
//  TaskListPresenter.swift
//  VIP_MyToDos
//

import UIKit

typealias TaskListPresenterInput = TaskListInteractorOutput
typealias TaskListPresenterOutput = TaskListViewControllerInput

final class TaskListPresenter {
    weak var viewController: TaskListPresenterOutput?
}

extension TaskListPresenter: TaskListPresenterInput {

    func navigateBack() {
        viewController?.navigateToHome()
    }
    
    func showAddTask(response: TaskListModel.AddTask.Response) {
        let viewModel = TaskListModel.AddTask.ViewModel(taskList: response.taskList, addTaskDelegate: response.addTaskDelegate)
        viewController?.showAddTaskView(viewModel: viewModel)
    }
    
    func presentTasks(response: TaskListModel.FetchTasks.Response) {
        let viewModel = TaskListModel.FetchTasks.ViewModel(tasks: response.tasks)
        viewController?.presentLoadedTasks(viewModel: viewModel)
    }
    
    func removedTask(response: TaskListModel.RemoveTask.Response) {
        let viewModel = TaskListModel.RemoveTask.ViewModel(tasks: response.tasks)
        viewController?.presentRemainingTasks(viewModel: viewModel)
    }
    
    func updatedTask(response: TaskListModel.UpdateTask.Response) {
        let viewModel = TaskListModel.UpdateTask.ViewModel(tasks: response.tasks)
        viewController?.presentUpdatedTasks(viewModel: viewModel)
    }
}
