//
//  CCard+CoreDataProperties.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//
//

import Foundation
import CoreData


extension CCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CCard> {
        return NSFetchRequest<CCard>(entityName: "CCard")
    }

    @NSManaged public var bankname: String?
    @NSManaged public var cardholder: String?
    @NSManaged public var pin: Int32
    @NSManaged public var country: String?
    @NSManaged public var typecard: String?
    @NSManaged public var user: Client?

}

extension CCard : Identifiable {

}
