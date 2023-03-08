//
//  TasksListModel.swift
//  MVP_MyToDos
//
//  Created by Raúl Ferrer on 10/5/22.
//

import Foundation
import CoreData

struct TasksListModel {
    var id: String!
    var title: String!
    var icon: String!
    var tasks: [TaskModel]!
    var createdAt: Date!
}

extension TasksListModel: EntityModelMapProtocol {
    
    typealias EntityType = TasksList
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let tasksList: TasksList = .init(context: context)
        tasksList.id = id
        tasksList.title = title
        tasksList.icon = icon
        if let tasks = tasks {
            tasks.forEach({
                $0.mapToEntityInContext(context).list = tasksList
            })
        }
        tasksList.createdAt = createdAt

        return tasksList
    }
    
    static func mapFromEntity(_ entity: TasksList) -> Self {
        
        guard let tasksListed = entity.tasks else {
            return .init(title: entity.title,
                         icon: entity.icon,
                         tasks: [TaskModel](),
                         createdAt: Date())
        }
        
        var tasks = [TaskModel]()
        for task in tasksListed {
            tasks.append(TaskModel.mapFromEntity(task as! Task))
        }
        
        return .init(id: entity.id,
                     title: entity.title,
                     icon: entity.icon,
                     tasks: tasks,
                     createdAt: entity.createdAt)
    }
}
