//
//  User+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var hint: String?
    @NSManaged public var password: String?
    @NSManaged public var web: WebApp?
    @NSManaged public var card: Card?

}

extension User : Identifiable {

}
