//
//  ViewController.swift
//  m8It_task
//
//  Created by Gopinath Vaiyapuri on 30/07/22.
//

import UIKit
import CoreData

class ViewController: UIViewController,Backhelper {
    
    
    func onSavedDB() {
        
        listData = []
        tableView.reloadData()
        initDataBase()
        
    }

    
    var listData:[UserModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataBase()
    }
    
    @IBAction func addUserTap(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "AddUserViewController") as! AddUserViewController
        next.backHelper = self
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    func initDataBase(){
        do{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            let result = try context.fetch(request)
            for resultData in result as! [NSManagedObject] {
                let user = UserModel(name: "\(resultData.value(forKey: "name") as! String)", email: "\(resultData.value(forKey: "email") as! String)", location: "\(resultData.value(forKey: "location") as! String)")
                listData.append(user)
                print(listData)
            }
            self.tableView.reloadData()
            
        }catch{
            debugPrint("Can't save")
        }
        
    }
    
    
    
    
}


extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! TableViewCell
        
        cell.emailText.text = listData[indexPath.row].email
        cell.nameText.text = listData[indexPath.row].name
        cell.locationText.text = listData[indexPath.row].location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ViewUserViewController") as! ViewUserViewController
        next.user = listData[indexPath.row]
        next.backHelper = self
        navigationController?.pushViewController(next, animated: true)
        
    }
}

