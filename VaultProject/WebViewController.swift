//
//  WebViewController.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//

import UIKit

class WebViewController: UIViewController {

    var webApp: WApp?
    
    @IBOutlet weak var webName: UITextField!
    
    @IBOutlet weak var emailView: UITextField!
    
    @IBOutlet weak var usernameView: UITextField!
    
    @IBOutlet weak var passView: UITextField!
    
    @IBOutlet weak var uriView: UITextField!
    
    @IBOutlet weak var showBtn: UIButton!
    
    var isHidden = false
    
    var userSession: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webName.isUserInteractionEnabled = false
        emailView.isUserInteractionEnabled = false
        usernameView.isUserInteractionEnabled = false
        passView.isUserInteractionEnabled = false
        passView.isSecureTextEntry = true
        uriView.isUserInteractionEnabled = false
        
        webName.text = webApp?.webname
        emailView.text = webApp?.email
        usernameView.text = webApp?.username
        passView.text = webApp?.password
        uriView.text = webApp?.uri
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ShowPasswordPressed(_ sender: Any) {
        if isHidden {
            let image = UIImage(systemName: "eye")
            showBtn.setImage(image, for: .normal)
            isHidden = false
        }
        else {
            let image = UIImage(systemName: "eye.fill")
            showBtn.setImage(image, for: .normal)
            isHidden = true
        }
    }
    
    @IBAction func EditWebPressed(_ sender: Any) {
        performSegue(withIdentifier: "editWeb", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editWeb" {
            let dst = segue.destination as! EditWebViewController
            dst.webAppTemp = self.webApp
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
