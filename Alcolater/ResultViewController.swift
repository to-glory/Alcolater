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
    @IBOutlet var recomendationLabel: UILabel!
    @IBOutlet var backTitle: UIButton!
    @IBOutlet var infoBtn: UIButton!
    
    
    var alcoholUserList = [String]()
    var finalValue = [Double]()
    var volume = 0.0
    var updValue = [Double]()
    var selectedAlcohol = [Bool]()
    var alcoholUserFortress = [Double]()
    var activeAlcohol = 0
    var cellValue = 0.0
    var cellIndex = 0
    var blurCheck = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        recomendationLabel.text = NSLocalizedString("Result", comment: "Результат:")
        backTitle.setTitle(NSLocalizedString("Back", comment: "Назад"), forState: .Normal)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ResultViewController.longPress(_:)))
        self.tableView.addGestureRecognizer(longPressRecognizer)
        selectedAlcohol = [Bool](count: alcoholUserList.count, repeatedValue: true)
        print("Volume: \(volume)")
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            let touchPoint = longPressGestureRecognizer.locationInView(self.tableView)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                if selectedAlcohol[indexPath.row] == true{
                    cellIndex = indexPath.row
                    cellValue = finalValue[indexPath.row]
                    selectedAlcohol[cellIndex] = false
                    volumeAlert(cellIndex)
                    //performSegueWithIdentifier("cellSegue", sender: nil)
                }
            }
        }
    }
    

    func volumeAlert(index: Int) {
        let alertController = UIAlertController(title: NSLocalizedString("Volume", comment: "Объем"), message: alcoholUserList[index], preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Ok", style: .Default) { (_) in
            let field = alertController.textFields![0]
            //===========
            self.updValue.removeAll()
            let spirtVolume = [Double](count: self.alcoholUserList.count, repeatedValue: self.volume/Double(self.alcoholUserList.count))
            print(spirtVolume)
            let newVolume = Double(field.text!)! * Double(self.alcoholUserFortress[self.cellIndex]) / 100
            print(newVolume)
            if newVolume < self.volume {
            var delta = spirtVolume[self.cellIndex] - newVolume
            print(delta)
            var newValue = spirtVolume
            newValue[self.cellIndex] = newVolume
            print(newValue)
            var count = 0.0
            for i in 0..<self.alcoholUserList.count {
                if self.selectedAlcohol[i] == true {
                    count+=1
                }
            }
            delta = delta/count
            for i in 0..<self.alcoholUserList.count {
                if self.selectedAlcohol[i] == true {
                    newValue[i] = newValue[i] + delta
                }
            }
            
            for i in 0..<self.alcoholUserFortress.count {
                let spirt = self.alcoholUserFortress[i] / 100
                if self.selectedAlcohol[i] == true {
                    print(spirt)
                    newValue[i] = newValue[i] / spirt
                } else if i == self.cellIndex {
                    newValue[self.cellIndex] = newVolume / spirt
                } else {
                    newValue[i] = self.finalValue[i]
                }
            }
            print(newValue)
            self.finalValue = newValue
            print(self.alcoholUserFortress)
            
            //===========
            self.view.endEditing(true)
            self.selectedAlcohol[index] = true
            self.selectedAlcohol.removeAll()
            self.tableView.reloadData()
            self.selectedAlcohol = [Bool](count: self.alcoholUserList.count, repeatedValue: true)
            print("List upd: \(self.selectedAlcohol)")
            } else {
                let nf = self.volume / (self.alcoholUserFortress[index] / 100)
                self.selectedAlcohol[index] = true
                self.wrongAlert(Int(nf))
            }
            //===========
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Отмена"), style: .Cancel) { (_) in
            self.selectedAlcohol[self.cellIndex] = true
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            if self.finalValue[index] < 1000 {
                textField.placeholder = String(Int(round(self.finalValue[index] / 10) * 10))
                textField.text = String(Int(round(self.finalValue[index] / 10) * 10))
            } else {
                textField.placeholder = String(Int(self.finalValue[index]))
                textField.text = String(Int(self.finalValue[index]))
            }
            textField.keyboardType = .NumberPad
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func wrongAlert(index: Int) {
            let alertController = UIAlertController(title: NSLocalizedString("Error!", comment: "Ошибка!"), message: NSLocalizedString("Invalid value. Enter a value less then", comment: "Введите меньше") + " \(index)" + " " + NSLocalizedString("ml", comment: "мл"), preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default) { (_) in
                self.volumeAlert(self.cellIndex)
        }
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alcoholUserList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        var lValue = 0.0
        if finalValue[indexPath.row] >= 1000 {
            lValue = finalValue[indexPath.row]/1000
            cell.detailTextLabel!.text = String(format: "%.1f", lValue) + " " + NSLocalizedString("l", comment: "л")
        } else if finalValue[indexPath.row] < 1000 {
            cell.detailTextLabel!.text = "\(Int(round(finalValue[indexPath.row] / 10) * 10))" + " " + NSLocalizedString("ml", comment: "мл")
        }
        cell.textLabel!.text = alcoholUserList[indexPath.row]
        
        if selectedAlcohol[indexPath.row] == true {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let count = finalValue.count
            var spirtValue = finalValue
            for i in 0..<count {
                spirtValue[i] = finalValue[i] * alcoholUserFortress[i] / 100
            }
            let deltedValue = spirtValue[indexPath.row]
            spirtValue.removeAtIndex(indexPath.row)
            alcoholUserFortress.removeAtIndex(indexPath.row)
            finalValue.removeAtIndex(indexPath.row)
            alcoholUserList.removeAtIndex(indexPath.row)
            selectedAlcohol.removeAtIndex(indexPath.row)
            var newValue = finalValue
            var trueAlcohol = 0.0
            for i in 0..<selectedAlcohol.count {
                if selectedAlcohol[i] == true {
                    trueAlcohol+=1
                }
            }
            
            for i in 0..<finalValue.count {
                let spirt = self.alcoholUserFortress[i] / 100
                if selectedAlcohol[i] == true {
                    newValue[i] = (spirtValue[i] + deltedValue / trueAlcohol) / spirt
                }
            }
            finalValue = newValue
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if selectedCell.accessoryType == .Checkmark {
            selectedAlcohol[indexPath.row] = false
            selectedCell.accessoryType = .None
        } else {
            selectedAlcohol[indexPath.row] = true
            selectedCell.accessoryType = .Checkmark
        }
        print(selectedAlcohol)
        print(finalValue)
    }
    
    
    
    @IBAction func backBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func infoBtn(sender: AnyObject) {
       
    }
    
    
    
    
}
