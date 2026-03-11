//
//  Syllabary+CoreDataProperties.swift
//  Manabu
//
//  Created by Luke on 10/03/2026.
//
//

public import Foundation
public import CoreData


public typealias SyllabaryEntityCoreDataPropertiesSet = NSSet

extension SyllabaryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SyllabaryEntity> {
        return NSFetchRequest<SyllabaryEntity>(entityName: "SyllabaryEntity")
    }

    @NSManaged public var eventRaw: String?
    @NSManaged public var charactersSeen: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var totalCharacters: Int64

}

extension SyllabaryEntity : Identifiable {

}
