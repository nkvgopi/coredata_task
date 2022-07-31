//
//  ViewUserViewController.swift
//  m8It_task
//
//  Created by Gopinath Vaiyapuri on 31/07/22.
//

import Foundation
import UIKit
import CoreData


class ViewUserViewController:UIViewController{
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var user:UserModel!
    var backHelper:Backhelper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user != nil {
            name.text = user.name ?? ""
            email.text = user.email ?? ""
            location.text = user.location ?? ""
        }
    }
    
    
    @IBAction func EditUserTap(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "AddUserViewController") as! AddUserViewController
        
        next.editUserData = user
        next.backHelper = backHelper
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    @IBAction func delelteUserTap(_ sender: Any) {
        
        let name:String = user.name!
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
        
        if backHelper != nil {
            backHelper.onSavedDB()
            navigationController?.popViewController(animated: true)
        }
        
        
    }
}
