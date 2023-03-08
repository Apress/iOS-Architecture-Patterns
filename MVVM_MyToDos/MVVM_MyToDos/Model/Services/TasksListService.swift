//
//  TasksListService.swift
//  MVVM_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//

import Foundation
import CoreData

protocol TasksListServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    func saveTasksList(_ list: TasksListModel)
    func fetchLists() -> [TasksListModel]
    func fetchListWithId(_ id: String) -> TasksListModel?
    func deleteList(_ list: TasksListModel)
}

class TasksListService: TasksListServiceProtocol {
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func saveTasksList(_ list: TasksListModel) {
        _ = list.mapToEntityInContext(context)
        coreDataManager.saveContext(context)
    }
    
    func fetchLists() -> [TasksListModel] {
        var lists = [TasksListModel]()
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            let value = try context.fetch(fetchRequest)
            lists = value.map({ TasksListModel.mapFromEntity($0) })
            lists = lists.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending })
        } catch {
            debugPrint("CoreData Error")
        }
        
        return lists
    }
    
    func fetchListWithId(_ id: String) -> TasksListModel? {
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            let listEntities = try context.fetch(fetchRequest)
            guard let list = listEntities.first else {
                return nil
            }
            return TasksListModel.mapFromEntity(list)
        } catch {
            debugPrint("CoreData Error")
            return nil
        }
    }
    
    func deleteList(_ list: TasksListModel) {
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", list.id)
            let listEntities = try context.fetch(fetchRequest)
            for listEntity in listEntities {
                context.delete(listEntity)
            }
            coreDataManager.saveContext(context)
        } catch {
            debugPrint("CoreData Error")
        }
    }
}
