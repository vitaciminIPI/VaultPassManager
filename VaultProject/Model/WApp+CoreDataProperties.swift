//
//  WApp+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//
//

import Foundation
import CoreData


extension WApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WApp> {
        return NSFetchRequest<WApp>(entityName: "WApp")
    }

    @NSManaged public var email: String?
    @NSManaged public var uri: String?
    @NSManaged public var webname: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var user: Client?

}

extension WApp : Identifiable {

}
