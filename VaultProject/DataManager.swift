//
//  DataManager.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//

import Foundation
import CoreData

class DataManager {
    // MARK: - Core Data
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Models")
        container.loadPersistentStores(completionHandler: {
            (storedDescription, error) in
            if let error = error as NSError? {
                fatalError("Unable to load persistent stores: \(error)")
            }
        })
        return container
    }()

    // MARK: - Save Data Function
    
    func addData(email: String, pass: String, hint: String) -> Users {
        let usr = Users(context: persistentContainer.viewContext)
        usr.email = email
        usr.password = pass
        usr.hint = hint
        
        return usr
    }
    
    func addWebCred(webname: String, email: String, username: String, pass: String, uri: String) -> Webs {
        let web = Webs(context: persistentContainer.viewContext)
        web.webname = webname
        web.username = username
        web.email = email
        web.password = pass
        web.uri = uri
        
        return web
    }
    
    func addCardCred(bank: String, cardHolder: String, pin: String, type: String, country: String) -> Cards {
        let card = Cards(context: persistentContainer.viewContext)
        card.bankname = bank
        card.cardholder = cardHolder
        card.pin = pin
        card.type = type
        card.country = country
        
        return card
    }
    
    // MARK: - Core Data Saving support
    
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
