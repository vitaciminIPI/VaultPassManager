//
//  AddWebViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 29/04/22.
//

import UIKit
import CryptoKit

class AddWebViewController: UIViewController {

    var webTemp: Webs?
    var userSession: Users?
    
    @IBOutlet weak var webName: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var emailAddr: UITextField!
    
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var uriTxt: UITextField!
    
    
    @IBOutlet weak var hiddenBtn: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var errorMsg = ""
    
    var isHidden = true
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Function
    
    @IBAction func HiddenBtnPressed(_ sender: Any) {
        if isHidden {
            let image = UIImage(systemName: "eye")
            hiddenBtn.setImage(image, for: .normal)
            passTxt.isSecureTextEntry = true
            isHidden = false
        }
        else {
            let images = UIImage(systemName: "eye.fill")
            hiddenBtn.setImage(images, for: .normal)
            passTxt.isSecureTextEntry = false
            isHidden = true
        }
        
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
        
        guard let pass = passTxt.text else {
            errorMsg = "Password must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let nameWeb = webName.text else {
            errorMsg = "Webname must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let username = userName.text else {
            errorMsg = "Username must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let uri = uriTxt.text else {
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
    
    func reset() {
        errorMsg = ""
        errorLabel.text = ""
        emailAddr.text = ""
        passTxt.text = ""
        webName.text = ""
        userName.text = ""
        uriTxt.text = ""
    }
    
    func hashFunction() -> String {
        let pass = passTxt.text!
        let data = Data(pass.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap { String(format: "%02x", $0)}.joined()
        print(hash)
        
        return hash
    }
    
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        let check = validateInput()
        if !check {
            errorLabel.isHidden = false
        }
        else {
            errorLabel.isHidden = true
            webTemp = DataManager.shared.addWebCred(webname: webName.text!, email: emailAddr.text!, username: userName.text!, pass: passTxt.text!, uri: uriTxt.text!)
            userSession?.addToWeb(webTemp!)
            DataManager.shared.save()
            
            performSegue(withIdentifier: "backToDashboard", sender: self)
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
