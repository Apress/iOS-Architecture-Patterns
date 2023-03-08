//
//  MockTaskService.swift
//  VIP_MyToDosTests
//
//  Created by Raúl Ferrer on 13/9/22.
//

@testable import VIP_MyToDos

class MockTaskService: TaskServiceProtocol {
    
    private var list: TasksListModel!
    private(set) var listTasks: [TaskModel] = [TaskModel]()

    required init(coreDataManager: CoreDataManager) {}
    
    convenience init(list: TasksListModel) {
        self.init(coreDataManager: CoreDataManager.shared)
        self.list = list
    }
    
    func fetchTasksForList(_ taskList: TasksListModel) -> [TaskModel] {
        listTasks = list.tasks
        return list.tasks
    }
    
    func saveTask(_ task: TaskModel, in taskList: TasksListModel) {
        list = taskList
        list.tasks.append(task)
        listTasks = list.tasks
    }
    
    func updateTask(_ task: TaskModel) {
        guard let tasks = list.tasks else { return }
        var updatedTasks = [TaskModel]()
        tasks.forEach({
            var updatedTask = $0
            if $0.id == task.id {
                updatedTask.done.toggle()
            }
            updatedTasks.append(updatedTask)
        })
        list.tasks = updatedTasks
        listTasks = updatedTasks
    }
    
    func deleteTask(_ task: TaskModel) {
        list.tasks = list.tasks.filter({ $0.id != task.id })
        listTasks = list.tasks
    }
}
