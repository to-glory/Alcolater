//
//  AddNewAlcoholViewController.swift
//  Alcolater
//
//  Created by To Glory! on 15/04/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit
import CoreData
class AddNewAlcoholViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var alcoholTitle: UITextField!
    @IBOutlet var alcoholFortress: UITextField!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var fortressTitle: UILabel!
    @IBOutlet var saveTitle: UIButton!
    @IBOutlet var backTitle: UIBarButtonItem!
    
    
    
    var alcohol: Alcohol!
    let locale = NSLocale.preferredLanguages().first!

    override func viewDidLoad() {
        super.viewDidLoad()
        alcoholFortress.delegate = self
        alcoholTitle.placeholder = NSLocalizedString("Whiskey", comment: "Виски")
        titleLabel.text = NSLocalizedString("Title", comment: "Название")
        fortressTitle.text = NSLocalizedString("Fortress", comment: "Крепость")
        saveTitle.setTitle(NSLocalizedString("Save", comment: "Добавить"), forState: .Normal)
        navigationBar.setHidesBackButton(true, animated: true)
        backTitle.title = NSLocalizedString("Back", comment: "Назад")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        alcoholTitle.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let length = !string.isEmpty ? alcoholFortress.text!.characters.count + 1 : alcoholFortress.text!.characters.count - 1
        
        if length > 3 {
            return false
        }
        
        return true
    }
    

    @IBAction func saveBtn(sender: AnyObject) {
        let title = alcoholTitle.text
        let fortress = alcoholFortress.text
        if title != "" && fortress != "" && Int(fortress!) < 100 {
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            alcohol = NSEntityDescription.insertNewObjectForEntityForName("Alcohol", inManagedObjectContext: managedObjectContext) as! Alcohol
            if locale.hasPrefix("ru") {
                alcohol.titleRu = title!
            } else {
                alcohol.titleEn = title!
            }
            alcohol.fortress = Double(fortress!)
            do {
                try managedObjectContext.save()
            } catch {
                print("error")
                navigationController?.popViewControllerAnimated(true)
                return
            }
            
        }
        navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
   
    @IBAction func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }

}
