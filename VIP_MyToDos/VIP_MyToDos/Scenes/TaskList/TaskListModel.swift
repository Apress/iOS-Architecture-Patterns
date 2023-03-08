//
//  TaskListModel.swift
//  VIP_MyToDos
//

import Foundation

enum TaskListModel {
    
    enum FetchTasks {
        struct Request {}
        
        struct Response {
            let tasks: [TaskModel]
        }
        
        struct ViewModel {
            let tasks: [TaskModel]
        }
    }
    
    enum AddTask {
        struct Request {}
        
        struct Response {
            let addTaskDelegate: AddTaskDelegate
            let taskList: TasksListModel
        }
        
        struct ViewModel {
            let taskList: TasksListModel
            let addTaskDelegate: AddTaskDelegate
        }
    }
    
    enum RemoveTask {
        struct Request {
            let index: IndexPath
        }
        
        struct Response {
            let tasks: [TaskModel]
        }
        
        struct ViewModel {
            let tasks: [TaskModel]
        }
    }
    
    enum UpdateTask {
        
        struct Request {
            let task: TaskModel
        }
        
        struct Response {
            let tasks: [TaskModel]
        }
        
        struct ViewModel {
            let tasks: [TaskModel]
        }
    }
}
