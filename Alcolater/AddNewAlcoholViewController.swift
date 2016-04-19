//
//  AddNewAlcoholViewController.swift
//  Alcolater
//
//  Created by To Glory! on 15/04/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit
import CoreData
class AddNewAlcoholViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var alcoholTitle: UITextField!
    @IBOutlet var alcoholFortress: UITextField!
    
    var alcohol: Alcohol!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setHidesBackButton(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func saveBtn(sender: AnyObject) {
        let title = alcoholTitle.text
        let fortress = alcoholFortress.text
        if title != "" && fortress != "" && Int(fortress!) < 100 {
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            alcohol = NSEntityDescription.insertNewObjectForEntityForName("Alcohol", inManagedObjectContext: managedObjectContext) as! Alcohol
            alcohol.title = title!
            alcohol.fortress = Double(fortress!)
            
            do {
                try managedObjectContext.save()
            } catch {
                print("error")
                return
            }
            
        }
        navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
   

}
