//
//  EntityModelProtocol.swift
//  MVC-MyToDos
//
//  Created by Raúl Ferrer on 3/4/22.
//

import Foundation
import CoreData

protocol EntityModelMapProtocol {

    associatedtype EntityType: NSManagedObject
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    static func mapFromEntity(_ entity: EntityType) -> Self
}
