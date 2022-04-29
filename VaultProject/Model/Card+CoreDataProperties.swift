//
//  Card+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var bankname: String?
    @NSManaged public var cardholder: String?
    @NSManaged public var pin: Int64
    @NSManaged public var typecard: String?
    @NSManaged public var country: String?

}

extension Card : Identifiable {

}
