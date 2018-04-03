//
//  CDFilm+CoreDataProperties.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/04/03.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//
//

import Foundation
import CoreData


extension CDFilm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFilm> {
        return NSFetchRequest<CDFilm>(entityName: "CDFilm")
    }

    @NSManaged public var director: String?
    @NSManaged public var filmId: Int16
    @NSManaged public var imageUrl: String?
    @NSManaged public var openingCrawlText: String?
    @NSManaged public var producer: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var dateCreated: NSDate?
    @NSManaged public var dateEdited: NSDate?
    @NSManaged public var rating: Double
    @NSManaged public var characters: NSSet?

}

// MARK: Generated accessors for characters
extension CDFilm {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: CDCharacter)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: CDCharacter)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}
