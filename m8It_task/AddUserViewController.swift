//
//  AddUserViewController.swift
//  m8It_task
//
//  Created by Gopinath Vaiyapuri on 31/07/22.
//

import Foundation
import UIKit
import CoreData




class AddUserViewController:UIViewController{
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var backHelper:Backhelper!
    var editUserData:UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(editUserData != nil){
            nameText.text = editUserData.name
            locationText.text = editUserData.location
            emailText.text = editUserData.email
            //   editUserData = nil
            
        }
        
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        let name:String = nameText.text ?? ""
        let email:String  = emailText.text ?? ""
        let location:String  = locationText.text ?? ""
        
        if name.isEmpty{
            
        }else if email.isEmpty {
            
        }else if location.isEmpty{
            
        }else{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            if editUserData != nil {
                let tempName:String = editUserData.name!
                editUserData = nil
                let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Users")
                fetchRequest.predicate = NSPredicate(format: "name = %@", tempName)
                
                do{
                    let test = try context.fetch(fetchRequest)
                    let objectUpdate = test[0] as! NSManagedObject
                    objectUpdate.setValue("\(name)", forKey: "name")
                    objectUpdate.setValue("\(email)", forKey: "email")
                    objectUpdate.setValue("\(location)", forKey: "location")
                    do{
                        try context.save()
                    }catch {
                        print(error)
                    }
                }catch{
                    print(error)
                }
                
                backHelper.onSavedDB()
                navigationController?.popToRootViewController(animated: true)
                
            }else{
                let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
                let recorData = NSManagedObject(entity: entity!, insertInto: context)
                recorData.setValue("\(name)", forKey: "name")
                recorData.setValue("\(email)", forKey: "email")
                recorData.setValue("\(location)", forKey: "location")
                
                do{
                    try context.save()
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
                    let result = try context.fetch(request)
                    print(result)
                    
                    if backHelper != nil {
                        backHelper.onSavedDB()
                        navigationController?.popViewController(animated: true)
                    }
                    
                }catch{
                    debugPrint("Can't save")
                }
                
            }
            
        }
    }
}
