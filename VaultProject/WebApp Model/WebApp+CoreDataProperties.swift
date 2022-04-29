//
//  WebApp+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//
//

import Foundation
import CoreData


extension WebApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WebApp> {
        return NSFetchRequest<WebApp>(entityName: "WebApp")
    }

    @NSManaged public var webname: String?
    @NSManaged public var email: String?
    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var uri: URL?

}

extension WebApp : Identifiable {

}
