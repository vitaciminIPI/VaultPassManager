//
//  Webs+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 29/04/22.
//
//

import Foundation
import CoreData


extension Webs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Webs> {
        return NSFetchRequest<Webs>(entityName: "Webs")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var uri: String?
    @NSManaged public var username: String?
    @NSManaged public var webname: String?
    @NSManaged public var user: Users?

}

extension Webs : Identifiable {

}
