//
//  EditCardViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 29/04/22.
//

import UIKit

class EditCardViewController: UIViewController {
    
    var cardTemp: CCard?
    
    var userSession: Client?

    @IBOutlet weak var bankName: UITextField!
    
    @IBOutlet weak var cardHolder: UITextField!
    
    @IBOutlet weak var typeCard: UITextField!
    
    @IBOutlet weak var pin: UITextField!
    
    @IBOutlet weak var Country: UITextField!
    
    @IBOutlet weak var isHidden: UIButton!
    
    var isHiddenn = true
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var errorMsg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pin.isHidden = true
        bankName.text = cardTemp?.bankname
        cardHolder.text = cardTemp?.cardholder
        pin.text = "\(cardTemp?.pin)"
        typeCard.text = cardTemp?.typecard
        Country.text = cardTemp?.country
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func HiddenBtnPressed(_ sender: Any) {
        
        if isHiddenn {
            let image = UIImage(systemName: "eye")
            isHidden.setImage(image, for: .normal)
            pin.isSecureTextEntry = true
            isHiddenn = false
        }
        else {
            let images = UIImage(systemName: "eye.fill")
            isHidden.setImage(images, for: .normal)
            pin.isSecureTextEntry = false
            isHiddenn = true
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let check = inputValidate()
        var pinInt: Int32
        
        if !check {
            errorLabel.isHidden = false
        }
        else {
            errorLabel.isHidden = true
//            let encryptPass =
            do {
                pinInt =  try Int32(pin.text!, format: .number)
                
                let newCard = DataManager.shared.addCardCred(bank: bankName.text!, cardHolder: cardHolder.text!, pin: pinInt, type: typeCard.text!, country: Country.text!)
                DataManager.shared.save()
                userSession?.addToCard(newCard)
            } catch {
                print("error int32")
            }
        }
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
        
        guard let pinCard = cardHolder.text else {
            errorMsg = "PIN must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let typeOfCard = cardHolder.text else {
            errorMsg = "Type card must be filled!"
            errorLabel.text = errorMsg
            return false
        }
        
        guard let countries = Country.text else {
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
        pin.text = ""
        Country.text = ""
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
