//
//  TaskService.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import CoreData

protocol TaskServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    func saveTask(_ task: TaskModel, in taskList: TasksListModel)
    func fetchTasksForList(_ taskList: TasksListModel) -> [TaskModel]
    func updateTask(_ task: TaskModel)
    func deleteTask(_ task: TaskModel)
}

class TaskService: TaskServiceProtocol {
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func saveTask(_ task: TaskModel, in taskList: TasksListModel) {
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", taskList.id)
            guard let list  = try context.fetch(fetchRequest).first else {
                return
            }
            
            let taskEntity = task.mapToEntityInContext(context)
            list.addToTasks(taskEntity)
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("CoreData Error")
        }
    }
    
    func fetchTasksForList(_ taskList: TasksListModel) -> [TaskModel] {
        var tasks = [TaskModel]()
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", taskList.id)
            guard let list  = try context.fetch(fetchRequest).first,
                  let taskEntities = list.tasks else {
                return tasks
            }
            
            tasks = taskEntities.map({ TaskModel.mapFromEntity($0 as! Task) })
        } catch {
            debugPrint("CoreData Error")
        }
        
        return tasks
    }
    
    func updateTask(_ task: TaskModel) {
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", task.id)
            guard let taskEntity = try context.fetch(fetchRequest).first else {
                return
            }
            
            taskEntity.done = task.done
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("CoreData Error")
        }
    }
    
    func deleteTask(_ task: TaskModel) {
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", task.id)
            let taskEntities = try context.fetch(fetchRequest)
            for taskEntity in taskEntities {
                context.delete(taskEntity)
            }
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("CoreData Error")
        }
    }
}
