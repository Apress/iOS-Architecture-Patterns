//
//  InMemoryCoreDataManager.swift
//  VIP_MyToDos
//
//  Created by Raúl Ferrer on 12/7/22.
//

import Foundation
import CoreData

@testable import VIP_MyToDos

class InMemoryCoreDataManager: CoreDataManager {
    
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
        persistentStoreDescription.shouldAddStoreAsynchronously = false
        
        let container = NSPersistentContainer(name: "ToDoList")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer = container
    }
}
