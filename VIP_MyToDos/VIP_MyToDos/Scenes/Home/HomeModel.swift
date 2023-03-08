//
//  HomeModel.swift
//  VIP_MyToDos
//

import Foundation

enum HomeModel {
    
    enum FetchTasksLists {
        struct Request {}
        
        struct Response {
            let tasksLists: [TasksListModel]
        }
        
        struct ViewModel {
            let tasksLists: [TasksListModel]
        }
    }
    
    enum AddTasksList {
        struct Request {}
        
        struct Response {
            let addListDelegate: AddListDelegate
        }
        
        struct ViewModel {
            let addListDelegate: AddListDelegate
        }
    }
    
    enum SelectTasksList {
        struct Request {
            let index: IndexPath
        }
        
        struct Response {
            let selectedListDelegate: SelectedListDelegate
            let tasksList: TasksListModel
        }
        
        struct ViewModel {
            let selectedListDelegate: SelectedListDelegate
            let tasksList: TasksListModel
        }
    }
    
    enum RemoveTasksList {
        struct Request {
            let index: IndexPath
        }
        
        struct Response {
            let list: TasksListModel
        }
    }
}
