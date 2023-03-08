//
//  Task+CoreDataProperties.swift
//  MVVM-C_MyToDos
//
//  Created by Raúl Ferrer on 11/6/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var done: Bool
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var list: TasksList?

}

extension Task : Identifiable {

}
