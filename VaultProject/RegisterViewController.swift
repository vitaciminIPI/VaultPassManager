//
//  RegisterViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 27/04/22.
//

import UIKit
import CryptoKit
import CoreData

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    
    
    @IBOutlet weak var passTxt: UITextField!
    
    
    @IBOutlet weak var confirmTxt: UITextField!
    
    
    @IBOutlet weak var hintTxt: UITextField!
    
    @IBOutlet weak var seeButton: UIButton!
    
    @IBOutlet weak var seeButton2: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var isLookin = false
    
    var isLookin2 = false
    
    var errorMsg = ""
    
    var userSession: Client?
    
//    Debug Core Data
//    var userFetch: NSFetchRequest<User> = User.fetchRequest()
//    var users: [User] = []
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "blue")
        self.title = "RegisterView"
        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
    }

    @IBAction func PassEyePressed(_ sender: UIButton) {
        if isLookin {
            passTxt.isSecureTextEntry = false
            let logo = UIImage(systemName: "eye.fill")
            sender.setImage(logo, for: .normal)
            isLookin = false
        }
        else {
            passTxt.isSecureTextEntry = true
            let logo = UIImage(systemName: "eye")
            sender.setImage(logo, for: .normal)
            isLookin = true
        }
    }
    
    // MARK: - Button n func
    
    @IBAction func ConfEyePressed(_ sender: UIButton) {
        if isLookin2 {
            confirmTxt.isSecureTextEntry = false
            let logo = UIImage(systemName: "eye.fill")
            sender.setImage(logo, for: .normal)
            isLookin2 = false
        }
        else {
            confirmTxt.isSecureTextEntry = true
            let logo = UIImage(systemName: "eye")
            sender.setImage(logo, for: .normal)
            isLookin2 = true
        }
    }
    
    func checkDuplicateData () -> Bool {
        var temp: [Client] = []
        let context = DataManager.shared.persistentContainer.viewContext
        let request = Client.fetchRequest() as NSFetchRequest<Client>
        let pred = NSPredicate(format: "email LIKE %@", emailTxt.text!)
        request.predicate = pred
        do {
            temp = try context.fetch(request)
            if !temp.isEmpty {
                errorMsg = "Invalid email"
                errorLabel.text = errorMsg
                return false
            }
        } catch {
            print("error")
        }
        return true
    }
    
    func reset() {
        errorMsg = ""
        errorLabel.text = ""
        emailTxt.text = ""
        passTxt.text = ""
        confirmTxt.text = ""
        hintTxt.text = ""
    }
    
    func emailValidation(email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
        
    }

    func validateInput() -> Bool {
        guard let email = emailTxt.text else {
            errorMsg = "Email must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let pass = passTxt.text else {
            errorMsg = "Password must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let conf = confirmTxt.text else {
            errorMsg = "Confirm password must be filled"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let hint = hintTxt.text else {
            errorMsg = "Hint must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        if email.isEmpty {
            errorMsg = "Email must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if pass.isEmpty {
            errorMsg = "Password must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if conf.isEmpty {
            errorMsg = "Confirm password must be filled"
            errorLabel.text = errorMsg
            return false
        }
        else if hint.isEmpty {
            errorMsg = "Hint must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if !emailValidation(email: email) {
            errorMsg = "Invalid email address!"
            errorLabel.text = errorMsg
            return false
        }
        else if pass.count <= 5 {
            errorMsg = "Password length must be more than 5 characters"
            errorLabel.text = errorMsg
            return false
        }
        else if conf != pass {
            errorMsg = "Confirm password must be the same as password!"
            errorLabel.text = errorMsg
            return false
        }
        else if hint.count <= 5 {
            errorMsg = "Hint length must be more than 5 characters"
            errorLabel.text = errorMsg
            return false
        }
        
        return true
        
    }
    
    func hashFunction() -> String {
        let pass = passTxt.text!
        let data = Data(pass.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap { String(format: "%02x", $0)}.joined()
        print(hash)
        
        return hash
    }
    
    @IBAction func SignUpPressed(_ sender: Any) {
        
        let check = validateInput()
        let checkDuplicate = checkDuplicateData()
        if !check {
            errorLabel.isHidden = false
        }
        else if !checkDuplicate {
            errorLabel.isHidden = false
        }
        else {
            errorLabel.isHidden = true
            let hashedPass = hashFunction()
            let user = DataManager.shared.addData(email: emailTxt.text!, pass: hashedPass, hint: hintTxt.text!)
            userSession = user
            DataManager.shared.save()
            reset()
            
            performSegue(withIdentifier: "goDashboard", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Dashboard" {
            let dst = segue.destination as! Dashboard
            dst.userSession = self.userSession
        }
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
