//
//  EditWebViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//

import UIKit
import CryptoKit

class EditWebViewController: UIViewController {

    var webAppTemp: Webs?
    
    @IBOutlet weak var webName: UITextField!
    
    @IBOutlet weak var emailAddr: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var weburi: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var showPassBtn: UIButton!
    
    var errorMsg = ""
    
    var userSession: Users?
    
    var isHidden = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.isSecureTextEntry = true
        errorLabel.isHidden = true
        webName.text = webAppTemp?.webname
        emailAddr.text = webAppTemp?.email
        username.text = webAppTemp?.username
        password.text = webAppTemp?.password
        weburi.text = webAppTemp?.uri
        // Do any additional setup after loading the view.
    }
    
    func reset() {
        errorMsg = ""
        errorLabel.text = ""
        emailAddr.text = ""
        password.text = ""
        webName.text = ""
        username.text = ""
        weburi.text = ""
    }
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
//        let check = validateInput()
        performSegue(withIdentifier: "backToDashboard", sender: self)
//        if !check {
//            errorLabel.isHidden = false
//        } else {
//            errorLabel.isHidden = true
//            let hashedPass = hashFunction()
//            let newWebApp = DataManager.shared.addWebCred(webname: webName.text!, email: emailAddr.text!, username: username.text!, pass: hashedPass, uri: weburi.text!)
//            DataManager.shared.save()
//            userSession?.addToWeb(newWebApp)
//            reset()
//        }
    }
    
    
    func emailValidation(email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
        
    }

    func validateInput() -> Bool {
        guard let email = emailAddr.text else {
            errorMsg = "Email must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let pass = password.text else {
            errorMsg = "Password must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let nameWeb = webName.text else {
            errorMsg = "Webname must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let username = username.text else {
            errorMsg = "Username must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let uri = weburi.text else {
            errorMsg = "URI must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        if nameWeb.isEmpty {
            errorMsg = "Webname must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if email.isEmpty {
            errorMsg = "Email must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if username.isEmpty {
            errorMsg = "Username must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if pass.isEmpty {
            errorMsg = "Password must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if uri.isEmpty {
            errorMsg = "URI must be filled!"
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
        
        return true
        
    }
    
    func hashFunction() -> String {
        let pass = password.text!
        let data = Data(pass.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap { String(format: "%02x", $0)}.joined()
        print(hash)
        
        return hash
    }
    
    
    @IBAction func ShowPassword(_ sender: Any) {
        if isHidden {
            let image = UIImage(systemName: "eye")
            showPassBtn.setImage(image, for: .normal)
            isHidden = false
            password.isSecureTextEntry = true
        }
        else {
            let image = UIImage(systemName: "eye.fill")
            showPassBtn.setImage(image, for: .normal)
            isHidden = true
            password.isSecureTextEntry = false
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
