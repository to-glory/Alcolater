//
//  AlcoholViewController.swift
//  Alcolater
//
//  Created by To Glory! on 15/04/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit
import CoreData

class AlcoholViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var backTitle: UIButton!
    @IBOutlet var calculateTitle: UIButton!
    @IBOutlet var navBar: UINavigationItem!
    

    var fetchResultController: NSFetchedResultsController!
    var alcoholList = [String: Double]()
    var alcoholUserList = [String]()
    var alcoholUserFortress = [Double]()
    var finalValue = [Double]()
    var isCheck = [Bool]()
    var volume = 0.0
    var sortDescriptor = NSSortDescriptor()
    var sort = false
    let locale = NSLocale.preferredLanguages().first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title = NSLocalizedString("Choose the drinks", comment: "Выберите напитки")
        backTitle.setTitle(NSLocalizedString("Back", comment: "Назад"), forState: .Normal)
        calculateTitle.setTitle(NSLocalizedString("Calculate", comment: "Рассчитать"), forState: .Normal)
        
        navigationBar.setHidesBackButton(true, animated: true)
        let fetchRequest = NSFetchRequest(entityName: "Alcohol")
        sortDescriptor = NSSortDescriptor(key: "fortress", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
            } catch {
                print("error")
            }
        }
        print("Volume: \(volume)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections![section].numberOfObjects
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let alcohol = fetchResultController.objectAtIndexPath(indexPath) as! Alcohol
        isCheck.append(false)
        if locale.hasPrefix("ru") {
        cell.textLabel?.text = alcohol.titleRu
        } else {
            cell.textLabel?.text = alcohol.titleEn
        }
        cell.detailTextLabel?.text = "\(Int(alcohol.fortress!))" + "%"
        if isCheck[indexPath.row] {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alcohol = fetchResultController.objectAtIndexPath(indexPath) as! Alcohol
        let selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if isCheck[indexPath.row] == false{
            if locale.hasPrefix("ru") {
                alcoholList.updateValue(Double(alcohol.fortress!), forKey: alcohol.titleRu!)
            } else {
                alcoholList.updateValue(Double(alcohol.fortress!), forKey: alcohol.titleEn!)
            }
            selectedCell.accessoryType = .Checkmark
            isCheck[indexPath.row] = true
        print(alcoholList)
        } else if isCheck[indexPath.row] == true {
            if locale.hasPrefix("ru") {
            alcoholList.removeValueForKey(alcohol.titleRu!)
            } else {
                alcoholList.removeValueForKey(alcohol.titleEn!)
            }
            selectedCell.accessoryType = .None
            isCheck[indexPath.row] = false
            print(alcoholList)
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
            case .Delete:
            if let _newIndexPath = newIndexPath {
                tableView.deleteRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _newIndexPath = newIndexPath {
                tableView.reloadRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    @IBAction func resultBtn(sender: AnyObject) {
        alcoholUserList.removeAll()
        alcoholUserFortress.removeAll()
        finalValue.removeAll()
            for (name, fortress) in alcoholList {
                alcoholUserList.append(name)
                alcoholUserFortress.append(fortress)
            }
        print(alcoholUserFortress)
        print(alcoholUserList)
        let count = alcoholUserFortress.count
        for i in 0..<count {
            finalValue.append((volume/(Double(alcoholUserFortress[i])/100))/Double(count))
        }
        print(finalValue)
        performSegueWithIdentifier("next", sender: self)
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "next" {
            let destinationVC = segue.destinationViewController as! ResultViewController
            destinationVC.alcoholUserList = alcoholUserList
            destinationVC.alcoholUserFortress = alcoholUserFortress
            destinationVC.finalValue = finalValue
            destinationVC.volume = volume
        }
    }

}
