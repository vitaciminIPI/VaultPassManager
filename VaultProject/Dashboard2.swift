//
//  Dashboard2.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//

import UIKit
import CoreData

class Dashboard2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let floatingButton: UIButton = {
        let button = UIButton()
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        // Corner Radius
//        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemBlue
        
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    var cards: [CCard] = []
    
    var cardTemp: CCard?
    
    let context = DataManager.shared.persistentContainer.viewContext
    
    let dataFetch = CCard.fetchRequest() as NSFetchRequest<CCard>
    
    var userSession: Client?
    
    func fetchData() {
        do {
            cards = try context.fetch(dataFetch)
        } catch {
            print("Failed to fetch cards")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CustomTableViewCell2
        cell.bankName.text = cards[indexPath.row].bankname
        cell.cardHolder.text = cards[indexPath.row].cardholder
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.dataSource = self
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 100, width: 60, height: 60)
    }
    
    @objc func didTapButton() {
        performSegue(withIdentifier: "goAddCard", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cardTemp = self.cards[indexPath.row]
        performSegue(withIdentifier: "goCardView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goCardView" {
            let dst = segue.destination as! CardViewController
            dst.cardTemp = self.cardTemp
            dst.userSession = self.userSession
        }
        else if segue.identifier == "goAddCard" {
            let dst = segue.destination as! AddCardViewController
            dst.cardTemp = self.cardTemp
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
