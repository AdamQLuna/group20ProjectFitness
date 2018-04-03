//
//  createAccountViewController.swift
//  Group20Alpha
//
//  Created by Ashley Moore on 3/20/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import CoreData

class createAccountViewController: UIViewController {
    @IBOutlet weak var createEmailTxtField: UITextField!
    
    @IBOutlet weak var createPw1TextField: UITextField!
    
    @IBOutlet weak var createPw2TextField: UITextField!
    
    @IBAction func createUserBtn(_ sender: Any) {
        if (createEmailTxtField.text! == "" || createPw1TextField.text! == "" || createPw2TextField.text! != createPw1TextField.text!){
            self.showAlert()
        } else {
            // causes the table data source methods to execute
            self.saveUser (emailAddress: createEmailTxtField.text!, userPassword: createPw1TextField.text!)
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveUser (emailAddress: String, userPassword: String){
        //grabbing the view that core data is in
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //grabbing the actual persistent container (core data) within app delegate -- data storage
        let managedContext = appDelegate.persistentContainer.viewContext
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let user = NSManagedObject(entity: entity!, insertInto:managedContext)
        // Set the attribute values
        user.setValue(emailAddress, forKey: "emailAddress")
        user.setValue(userPassword, forKey: "userPassword")
        
        // Commit the changes.
        do {
            try managedContext.save()
            
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func showAlert() {
        // create variable alertController given assignment constraints
        let alertController = UIAlertController(title: "Error", message: "Please check that you are using a UT e-mail and that your passwords ", preferredStyle: UIAlertControllerStyle.alert)
        //create the action of clicking the button
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
        
        alertController.addAction(OKAction)
        //call to alertController to display information
        self.present(alertController, animated: true, completion:nil)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
