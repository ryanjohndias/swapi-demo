//
//  CDCharacter+CoreDataProperties.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/04/02.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//
//

import Foundation
import CoreData


extension CDCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCharacter> {
        return NSFetchRequest<CDCharacter>(entityName: "CDCharacter")
    }

    @NSManaged public var personId: Int16
    @NSManaged public var name: String?

}
