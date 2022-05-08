//
//  AddCardViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 29/04/22.
//

import UIKit

class AddCardViewController: UIViewController {
    
    var cardTemp: Cards?
    var userSession: Users?
    var isHidden = true
    var errorMsg = ""
    
    @IBOutlet weak var bankName: UITextField!
    
    @IBOutlet weak var cardHolder: UITextField!
    
    @IBOutlet weak var pinTxt: UITextField!
    
    @IBOutlet weak var hiddenBtn: UIButton!
    
    @IBOutlet weak var typeCard: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var countryTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    func inputValidate() -> Bool {
        guard let bank = bankName.text else {
            errorMsg = "Bank name must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let cardHolders = cardHolder.text else {
            errorMsg = "Card holder must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let pinCard = pinTxt.text else {
            errorMsg = "PIN must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let typeOfCard = typeCard.text else {
            errorMsg = "Type card must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let countries = countryTxt.text else {
            errorMsg = "Country must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        if bank.isEmpty {
            errorMsg = "Bank name must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if cardHolders.isEmpty {
            errorMsg = "Card holder must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if pinCard.isEmpty {
            errorMsg = "PIN must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if typeOfCard.isEmpty {
            errorMsg = "Type card must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if countries.isEmpty {
            errorMsg = "Country must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        else if pinCard.count != 6 {
            errorMsg = "Invalid PIN"
            errorLabel.text = errorMsg
            return false
        }
        
        return true
    }
    
    func reset() {
        errorMsg = ""
        errorLabel.text = ""
        bankName.text = ""
        cardHolder.text = ""
        typeCard.text = ""
        pinTxt.text = ""
        countryTxt.text = ""
    }
    
    
    @IBAction func HiddenBtnPressed(_ sender: Any) {
        if isHidden {
            let image = UIImage(systemName: "eye")
            hiddenBtn.setImage(image, for: .normal)
            pinTxt.isSecureTextEntry = true
            isHidden = false
        }
        else {
            let images = UIImage(systemName: "eye.fill")
            hiddenBtn.setImage(images, for: .normal)
            pinTxt.isSecureTextEntry = false
            isHidden = true
        }
    }
    
    @IBAction func SaveBtnPressed(_ sender: Any) {
        let check = inputValidate()
        
        if !check {
            errorLabel.isHidden = false
        }
        else {
            errorLabel.isHidden = true
//            let encryptPass =
            let newCard = DataManager.shared.addCardCred(bank: bankName.text!, cardHolder: cardHolder.text!, pin: pinTxt.text!, type: typeCard.text!, country: countryTxt.text!)
            
            userSession?.addToCard(newCard)
            DataManager.shared.save()
            performSegue(withIdentifier: "backToDashboard2", sender: self)
            
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
