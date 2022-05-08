//
//  Cards+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 29/04/22.
//
//

import Foundation
import CoreData


extension Cards {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cards> {
        return NSFetchRequest<Cards>(entityName: "Cards")
    }

    @NSManaged public var bankname: String?
    @NSManaged public var cardholder: String?
    @NSManaged public var country: String?
    @NSManaged public var pin: String?
    @NSManaged public var type: String?
    @NSManaged public var user: Users?

}

extension Cards : Identifiable {

}
