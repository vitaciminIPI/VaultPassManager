//
//  LoginViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 27/04/22.
//

import UIKit
import CryptoKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    var errorMsg = ""
    
    let context = DataManager.shared.persistentContainer.viewContext
    
    var users: [Users] = []
    
    var userSession: Users!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLbl.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    // MARK: - function and button
    
    @IBAction func SignInPressed(_ sender: Any) {
        let check = validateInput()
        let request = Users.fetchRequest() as NSFetchRequest<Users>
        
        if !check {
            errorLbl.isHidden = false
        }
        else {
            errorLbl.isHidden = true
            let hashedPass = hashFunction()
            let pred = NSPredicate(format: "email LIKE %@ AND password LIKE %@", emailTxt.text!, hashedPass)
            request.predicate = pred
            do {
                users = try context.fetch(request)
    
                if !users.isEmpty {
                    userSession = users[0]
                    reset()
                    performSegue(withIdentifier: "goDashboard", sender: self)
                } else {
                    errorMsg = "Invalid credentials!"
                    errorLbl.text = errorMsg
                    errorLbl.isHidden = false
                }
            } catch {
                errorMsg = "There is no data in Core Data"
                errorLbl.text = errorMsg
                errorLbl.isHidden = false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDashboard" {
            let dst = segue.destination as! Dashboard
            dst.userSession = userSession
        }
    }
    
    @IBAction func SignUpPressed(_ sender: Any) {
        performSegue(withIdentifier: "registerView", sender: self)
    }
    
    func validateInput() -> Bool {
        guard let email = emailTxt.text else {
            errorMsg = "Email must be filled!"
            errorLbl.text = errorMsg
            return false
        }
        guard let pass = passwordTxt.text else {
            errorMsg = "Password must be filled!"
            errorLbl.text = errorMsg
            return false
        }
        
        if email.isEmpty {
            errorMsg = "Email must be filled!"
            errorLbl.text = errorMsg
            return false
        }
        else if pass.isEmpty {
            errorMsg = "Password must be filled!"
            errorLbl.text = errorMsg
            return false
        }
        else if !emailValidation(email: email) {
            errorMsg = "Invalid email address!"
            errorLbl.text = errorMsg
            return false
        }
        else if pass.count <= 5 {
            errorMsg = "Password length must be more than 5 characters"
            errorLbl.text = errorMsg
            return false
        }
        
        return true
    }
    
    func reset() {
        errorMsg = ""
        errorLbl.text = ""
        emailTxt.text = ""
        passwordTxt.text = ""
    }
    
    func emailValidation(email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
        
    }
    
    func hashFunction() -> String {
        let pass = passwordTxt.text!
        let data = Data(pass.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap { String(format: "%02x", $0)}.joined()
        
        return hash
    }
    
    @IBAction func logOut(_ seg: UIStoryboardSegue) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
