//
//  Client+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var hint: String?
    @NSManaged public var card: NSSet?
    @NSManaged public var web: NSSet?

}

// MARK: Generated accessors for card
extension Client {

    @objc(addCardObject:)
    @NSManaged public func addToCard(_ value: CCard)

    @objc(removeCardObject:)
    @NSManaged public func removeFromCard(_ value: CCard)

    @objc(addCard:)
    @NSManaged public func addToCard(_ values: NSSet)

    @objc(removeCard:)
    @NSManaged public func removeFromCard(_ values: NSSet)

}

// MARK: Generated accessors for web
extension Client {

    @objc(addWebObject:)
    @NSManaged public func addToWeb(_ value: WApp)

    @objc(removeWebObject:)
    @NSManaged public func removeFromWeb(_ value: WApp)

    @objc(addWeb:)
    @NSManaged public func addToWeb(_ values: NSSet)

    @objc(removeWeb:)
    @NSManaged public func removeFromWeb(_ values: NSSet)

}

extension Client : Identifiable {

}
