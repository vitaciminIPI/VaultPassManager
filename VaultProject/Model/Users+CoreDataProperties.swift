//
//  Users+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 29/04/22.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var hint: String?
    @NSManaged public var password: String?
    @NSManaged public var card: NSSet?
    @NSManaged public var web: NSSet?

}

// MARK: Generated accessors for card
extension Users {

    @objc(addCardObject:)
    @NSManaged public func addToCard(_ value: Cards)

    @objc(removeCardObject:)
    @NSManaged public func removeFromCard(_ value: Cards)

    @objc(addCard:)
    @NSManaged public func addToCard(_ values: NSSet)

    @objc(removeCard:)
    @NSManaged public func removeFromCard(_ values: NSSet)

}

// MARK: Generated accessors for web
extension Users {

    @objc(addWebObject:)
    @NSManaged public func addToWeb(_ value: Webs)

    @objc(removeWebObject:)
    @NSManaged public func removeFromWeb(_ value: Webs)

    @objc(addWeb:)
    @NSManaged public func addToWeb(_ values: NSSet)

    @objc(removeWeb:)
    @NSManaged public func removeFromWeb(_ values: NSSet)

}

extension Users : Identifiable {

}
