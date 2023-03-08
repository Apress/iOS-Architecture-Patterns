//
//  TasksListPresenter.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import Foundation

class TasksListPresenter {
    
    private weak var taskListView: TaskListViewDelegate?
    private var tasksListModel: TasksListModel!
    private var taskService: TaskServiceProtocol!
    private var tasksListService: TasksListServiceProtocol!
    private var tasks = [TaskModel]()

    init(taskListView: TaskListViewDelegate? = nil,
         tasksListModel: TasksListModel,
         taskService: TaskServiceProtocol,
         tasksListService: TasksListServiceProtocol) {
        self.taskListView = taskListView
        self.tasksListModel = tasksListModel
        self.taskService = taskService
        self.tasksListService = tasksListService
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextObjectsDidChange),
                                               name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: CoreDataManager.shared.mainContext)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasks()
    }
    
    var pageTitle: String {
        return tasksListModel.title
    }
    
    var numberOfTasks: Int {
        return tasks.count
    }
    
    func taskAtIndex(_ index: Int) -> TaskModel {
        return tasks[index]
    }
    
    func setupView() {
        taskListView?.setPageTitle(pageTitle)
        fetchTasks()
    }
    
    func fetchTasks() {
        guard let list = tasksListService.fetchListWithId(tasksListModel.id) else { return }
        tasksListModel = list
        tasks = tasksListModel.tasks.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending })
        
        print(tasks)
        taskListView?.reloadData()
    }
}

extension TasksListPresenter {

    func updateTask(_ task: TaskModel) {
        taskService.updateTask(task)
    }
    
    func removeTaskAtIndex(_ index: Int) {
        let task = taskAtIndex(index)
        taskService.deleteTask(task)
        tasks.remove(at: index)
    }
}
