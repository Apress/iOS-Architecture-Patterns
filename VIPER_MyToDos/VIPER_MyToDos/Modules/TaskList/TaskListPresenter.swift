//
//  TaskListPresenter.swift
//  VIPER_MyToDos
//
//  Created by Raúl Ferrer on 16/8/22.
//

import Foundation

class TaskListPresenter: ViewToPresenterTaskListProtocol {

    var view: PresenterToViewTaskListProtocol?
    var interactor: PresenterToInteractorTaskListProtocol?
    var router: PresenterToRouterTaskListProtocol?
    var tasks: [TaskModel] = [TaskModel]()
    
    func viewDidLoad() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fetchTasks),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
        interactor?.loadTasks()
    }
    
    func numberOfRowsInSection() -> Int {
        tasks.count
    }
    
    func taskAt(indexPath: IndexPath) -> TaskModel {
        tasks[indexPath.row]
    }
    
    func deleteRowAt(indexPath: IndexPath) {
        interactor?.deleteTaskAt(indexPath: indexPath)
    }
    
    func update(task: TaskModel) {
        interactor?.updateTask(task: task)
    }
    
    func addTask() {
        interactor?.addTask()
    }
    
    @objc private func fetchTasks() {
        interactor?.loadTasks()
    }
    
    func backAction() {
        router?.popToHomeFrom(view: view!)
    }
}

extension TaskListPresenter: InteractorToPresenterTaskListProtocol {
    
    func fetchedTasks(tasks: [TaskModel]) {
        self.tasks = tasks
        tasks.count == 0 ? view?.showEmptyState() : view?.hideEmptyState()
        view?.onFetchTasks()
    }
    
    func addTaskTo(list: TasksListModel) {
        router?.presentAddTaskOn(view: view!, forTaskList: list)
    }
}
