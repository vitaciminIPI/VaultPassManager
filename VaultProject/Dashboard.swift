//
//  Dashboard.swift
//  VaultProject
//
//  Created by daniel stefanus christiawan on 28/04/22.
//

import UIKit
import CoreData

class Dashboard: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - floating Button
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
    
    @IBOutlet weak var table: UITableView!
    
    var webApps: [Webs] = []
    
    var temp: Webs?
    
    let context = DataManager.shared.persistentContainer.viewContext
    
    let dataFetch = Webs.fetchRequest() as NSFetchRequest<Webs>
    
    var userSession: Users?
    
    // MARK: - VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        getData()
        table.dataSource = self
        table.delegate = self
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        table.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.table.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 100, width: 60, height: 60)
    }
    
    // MARK: - Function
    
    @objc func didTapButton() {
        performSegue(withIdentifier: "goAddWeb", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webApps.count
    }
    
    @IBAction func itemCardBtn(_ sender: Any) {
        performSegue(withIdentifier: "Dashboard2", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.webName.text = webApps[indexPath.row].webname
        cell.ownerName.text = webApps[indexPath.row].email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.temp = self.webApps[indexPath.row]
        self.performSegue(withIdentifier: "viewWeb", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let item = self.webApps[indexPath.row]
            
            self.context.delete(item)
            
            do {
                try self.context.save()
            } catch {
                print("error while saving")
            }
            
            self.getData()
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewWeb" {
            let dest = segue.destination as! WebViewController
            dest.webApp = self.temp
            dest.userSession = self.userSession
        }
        else if segue.identifier == "goAddWeb" {
            let dst = segue.destination as! AddWebViewController
            dst.userSession = self.userSession
        }
        else if segue.identifier == "Dashboard2" {
            let dst = segue.destination as! Dashboard2
            dst.userSession = self.userSession
        }
    }
    
    func getData() {
        let request: NSFetchRequest<Webs> = Webs.fetchRequest()
        request.predicate = NSPredicate(format: "user = %@", userSession!)

        do {
            webApps = try context.fetch(request)
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        } catch {
            print("Failed to fetch User's Web data")
        }

    }
    
    @IBAction func LogOutPressed(_ sender: Any) {
        userSession = nil
        performSegue(withIdentifier: "logOutToLogin", sender: self)
    }
    
    
    @IBAction func unwindSegue(_ seg: UIStoryboardSegue) {
        self.getData()
    }
    
    @IBAction func backFromDashboard2 (_ seg: UIStoryboardSegue) {
        
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
