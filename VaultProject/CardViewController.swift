//
//  CardViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 29/04/22.
//

import UIKit

class CardViewController: UIViewController {

    var cardTemp: Cards?
    
    var userSession: Users?
    
    @IBOutlet weak var bankName: UITextField!
    
    @IBOutlet weak var cardHolder: UITextField!
    
    @IBOutlet weak var PIN: UITextField!
    
    @IBOutlet weak var typeCard: UITextField!
    
    @IBOutlet weak var countryName: UITextField!
    
    var isHidden = true
    
    @IBOutlet weak var hiddenBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bankName.isUserInteractionEnabled = false
        cardHolder.isUserInteractionEnabled = false
        PIN.isUserInteractionEnabled = false
        typeCard.isUserInteractionEnabled = false
        countryName.isUserInteractionEnabled = false
        
        bankName.text = cardTemp?.bankname
        cardHolder.text = cardTemp?.cardholder
        PIN.text = cardTemp?.pin
        typeCard.text = cardTemp?.type
        countryName.text = cardTemp?.country
        // Do any additional setup after loading the view.
    }
    
    @IBAction func HideBtnPressed(_ sender: Any) {
        if isHidden {
            let image = UIImage(systemName: "eye")
            hiddenBtn.setImage(image, for: .normal)
            isHidden = false
            PIN.isSecureTextEntry = true
        }
        else {
            let image = UIImage(systemName: "eye.fill")
            hiddenBtn.setImage(image, for: .normal)
            isHidden = true
            PIN.isSecureTextEntry = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEditCard" {
            let dst = segue.destination as! EditCardViewController
            dst.cardTemp = self.cardTemp
            dst.userSession = self.userSession
            
        }
    }
    
    @IBAction func EditBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goEditCard", sender: self)
    }
    
    
    @IBAction func CopyToClipboard(_ sender: Any) {
        UIPasteboard.general.string = PIN.text
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
