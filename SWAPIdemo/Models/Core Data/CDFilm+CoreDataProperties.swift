//
//  CDFilm+CoreDataProperties.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/30.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//
//

import Foundation
import CoreData


extension CDFilm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFilm> {
        return NSFetchRequest<CDFilm>(entityName: "CDFilm")
    }

    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var filmId: Int16
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var director: String?
    @NSManaged public var producer: String?
    @NSManaged public var openingCrawlText: String?

}
