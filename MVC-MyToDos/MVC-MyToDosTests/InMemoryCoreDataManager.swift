//
//  InMemoryCoreDataManager.swift
//  MVC-MyToDosTests
//
//  Created by Raúl Ferrer on 8/5/22.
//

import Foundation
import CoreData

@testable import MVC_MyToDos

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
