//
//  ResultViewController.swift
//  Alcolater
//
//  Created by To Glory! on 16/04/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var alcoholUserList = [String]()
    var finalValue = [Double]()
    var volume = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alcoholUserList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        let count = finalValue.count
        if finalValue[indexPath.row] > 1000 {
            finalValue[indexPath.row] = finalValue[indexPath.row]/1000
            cell.volume.text = "l"
        } else if finalValue[indexPath.row] < 1000 {
            for i in 0..<count {
                switch finalValue[i] {
                case 1...75:
                    finalValue[i] = 50
                case 76...125:
                    finalValue[i] = 100
                case 126...175:
                    finalValue[i] = 150
                case 176...225:
                    finalValue[i] = 200
                case 226...275:
                    finalValue[i] = 250
                case 276...325:
                    finalValue[i] = 300
                case 326...375:
                    finalValue[i] = 350
                case 376...425:
                    finalValue[i] = 400
                case 426...475:
                    finalValue[i] = 450
                case 476...525:
                    finalValue[i] = 500
                case 526...575:
                    finalValue[i] = 550
                case 576...625:
                    finalValue[i] = 600
                case 626...675:
                    finalValue[i] = 650
                case 676...725:
                    finalValue[i] = 700
                case 726...775:
                    finalValue[i] = 750
                case 776...825:
                    finalValue[i] = 800
                case 826...875:
                    finalValue[i] = 850
                case 876...925:
                    finalValue[i] = 900
                case 926...999:
                    finalValue[i] = 950
                default:
                    print("error")
                }
            }
        }
        cell.title.text = alcoholUserList[indexPath.row]
        cell.value.text = "\(Int(finalValue[indexPath.row]))"
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            alcoholUserList.removeAtIndex(indexPath.row)
            //finalValue.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell: TableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as! TableViewCell
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        finalValue[indexPath.row] = Double(selectedCell.value.text!)!
        tableView.endEditing(true)
        print(finalValue)
    }
    
    
    @IBAction func backBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
