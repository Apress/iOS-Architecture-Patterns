//
//  InMemoryCoreDataManager.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 31/5/22.
//

import Foundation
import CoreData

@testable import MVP_MyToDos

class InMemoryCoreDataManager: CoreDataManager {
    
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
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
