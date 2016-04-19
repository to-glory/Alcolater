//
//  ViewController.swift
//  Alcolater
//
//  Created by To Glory! on 15/04/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var open = false
    
    var men = 0
    var women = 0
    var menWeight = 80
    var womenWeight = 60
    var time = 1
    var ppm = 0.5
    var alcoIndex = 0
    var ppm1 = 0.5
    var alcoData = ["Weakly", "Happly", "Till tou drop"]
    var  volume = 0.0
    
    @IBOutlet var subview: UIView!
    @IBOutlet var weightSettings: UIButton!
    @IBOutlet var menLabel: UILabel!
    @IBOutlet var womenLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var timerSlider: UISlider!
    @IBOutlet var menWeightField: UITextField!
    @IBOutlet var womenWeightField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return alcoData[row]
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alcoData.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func menPlus(sender: AnyObject) {
        men+=1
        menLabel.text = "\(men)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    alcoIndex = row
    switch alcoIndex {
    case 0:
    ppm = 0.5
    case 1:
    ppm = 1.5
    case 2:
    ppm = 2.5
    default:
    "error"
    }
    print(ppm)
    }
    @IBAction func hideKeyboard(sender: AnyObject) {
        menWeight = Int(menWeightField.text!)!
        womenWeight = Int(womenWeightField.text!)!
        view.endEditing(true)
    }
    
    @IBAction func menMinus(sender: AnyObject) {
        if men > 0 {
            men-=1
        }
        menLabel.text = "\(men)"
    }
    
    @IBAction func womenPlus(sender: AnyObject) {
        women+=1
        womenLabel.text = "\(women)"
    }
    
    @IBAction func womenMinus(sender: AnyObject) {
        if women > 0 {
            women-=1
        }
        womenLabel.text = "\(women)"
    }
    
    @IBAction func timerSlider(sender: AnyObject) {
        time = Int(timerSlider.value)
        timerLabel.text = "\(time) h"
    }
    

    @IBAction func weightSettings(sender: AnyObject) {
        if open == false {
        UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
            self.subview.transform = CGAffineTransformMakeTranslation(0, 302)
            }, completion: nil)
            open = true
            weightSettings.setTitle("Close", forState: .Normal)
        } else {
             UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
            self.subview.transform = CGAffineTransformIdentity
                 }, completion: nil)
            open = false
            weightSettings.setTitle("Weight settings", forState: .Normal)
            view.endEditing(true)
            menWeight = Int(menWeightField.text!)!
            womenWeight = Int(womenWeightField.text!)!
        }
        print(menWeight)
        print(womenWeight)
    }
    
    @IBAction func selectDrinks(sender: AnyObject) {
        volume = 0.0
        var Am = 0.0
        var Aw = 0.0
        var A = 0.0
        if time > 1 {
            ppm1 = ppm  + 0.15 * Double(time)
        } else {
            ppm1 = ppm
        }
        Am = ppm1 * Double(menWeight) * 0.7 * Double(men)
        print("Am = \(Am)")
        Aw = ppm1 * Double(womenWeight) * 0.6 * Double(women)
        print("Aw =\(Aw)")
        A = Am + Aw
        print("A = \(A)")
        volume = A / 0.79
        print("V = \(volume)")
        print("ppm = \(ppm1)")
        performSegueWithIdentifier("next", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "next" {
            let destinationVC = segue.destinationViewController as! UINavigationController
        let targetVC = destinationVC.topViewController as! AlcoholViewController
            targetVC.volume = volume
        }
    }

}

