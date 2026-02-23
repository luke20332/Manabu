//
//  GameModeEntity+CoreDataProperties.swift
//  
//
//  Created by Luke on 23/02/2026.
//
//

public import Foundation
public import CoreData


public typealias GameModeEntityCoreDataPropertiesSet = NSSet

extension GameModeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameModeEntity> {
        return NSFetchRequest<GameModeEntity>(entityName: "GameModeEntity")
    }

    @NSManaged public var eventRaw: String?
    @NSManaged public var highScore: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var imageType: String?
    @NSManaged public var imageValue: String?
    @NSManaged public var title: String?

}
