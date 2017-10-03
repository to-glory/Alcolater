//
//  ViewController.swift
//  Alcolater
//
//  Created by To Glory! on 15/04/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    var open = false
    
    var men = 0
    var women = 0
    var menWeight = 80
    var womenWeight = 60
    var time = 1
    var ppm = 0.59
    var alcoIndex = 0
    var ppm1 = 0.59
    var alcoData = [NSLocalizedString("Normal", comment: "Не чувствуется"), NSLocalizedString("Medium", comment: "Весело"), NSLocalizedString("Fun", comment: "До упаду")]
    var  volume = 0.0
    var alert = false
    
    @IBOutlet var subview: UIView!
    @IBOutlet var weightSettings: UIButton!
    @IBOutlet var menLabel: UILabel!
    @IBOutlet var womenLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var timerSlider: UISlider!
    @IBOutlet var menWeightField: UITextField!
    @IBOutlet var womenWeightField: UITextField!
    
    @IBOutlet var menTitle: UILabel!
    @IBOutlet var womenTitle: UILabel!
    @IBOutlet var weightSettingsTitle: UIButton!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var howDrunkLabel: UILabel!
    @IBOutlet var selectDrinksLabel: UIButton!
    @IBOutlet var menWeightTitle: UILabel!
    @IBOutlet var womenWeightTitle: UILabel!
    @IBOutlet var kgLabel: UILabel!
    @IBOutlet var kgLabel2: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
        menWeightField.delegate = self
        womenWeightField.delegate = self
        selectDrinksLabel.layer.zPosition = -1
        subview.layer.zPosition = 1
        //Localization
        menTitle.text = NSLocalizedString("Men", comment: "Мужчины")
        womenTitle.text = NSLocalizedString("Women", comment: "Женщины")
        weightSettings.setTitle(NSLocalizedString("Weight settings", comment: "Параметры веса"), forState: .Normal)
        durationLabel.text = NSLocalizedString("Duration", comment: "Длительность")
        howDrunkLabel.text = NSLocalizedString("How badly do you want to have fun?", comment: "Как сильно будете пить?")
        selectDrinksLabel.setTitle(NSLocalizedString("Select drinks", comment: "Выбор напитков"), forState: .Normal)
        timerLabel.text = NSLocalizedString("1 h", comment: "1 ч")
        menWeightTitle.text = NSLocalizedString("Average men's weight", comment: "Средний вес мужчин")
        womenWeightTitle.text = NSLocalizedString("Average women's weight", comment: "Средний вес женщин")
        kgLabel.text = NSLocalizedString("kg", comment: "кг")
        kgLabel2.text = NSLocalizedString("kg", comment: "кг")
        //
    }
    
    override func viewDidAppear(animated: Bool) {
        if alert == false {
            showAlertMessage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"]?.CGRectValue {
            scrollView.contentInset.bottom = keyboardFrame.height + 100
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //let length = !string.isEmpty ? menWeightField.text!.characters.count + 1 : menWeightField.text!.characters.count - 1
        var length1 = 0
        var length2 = 0
        if !string.isEmpty {
            length1 = menWeightField.text!.characters.count + 1
            length2 = womenWeightField.text!.characters.count + 1
        } else {
            length1 = menWeightField.text!.characters.count - 1
            length2 = womenWeightField.text!.characters.count - 1
        }
        if length1 > 4 || length2 > 4 {
            return false
        }
        return true
    }
    
    func showAlertMessage() {
        let alertController = UIAlertController(title: NSLocalizedString("Warning!", comment: "Внимание!"), message: NSLocalizedString("This app was developed for entertainment purposes only. Results of the calculation should be considered as a joke and must not be used to determine whether person is able to drive, cannot be provide as proof in court and should not be interpreted as a result of the medical examination", comment: "Предупреждение"), preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
        alert = true
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
    ppm = 0.59
    case 1:
    ppm = 1.8
    case 2:
    ppm = 2.8
    default:
    "error"
    }
    print(ppm)
    }
    @IBAction func hideKeyboard(sender: AnyObject) {
        if menWeightField.text! != "" && womenWeightField.text! != "" {
        menWeight = Int(menWeightField.text!)!
        womenWeight = Int(womenWeightField.text!)!
        view.endEditing(true)
            scrollView.contentInset.bottom = 0
        }
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
        timerLabel.text = "\(time)" + " " + NSLocalizedString("h", comment: "ч")
    }
    

    @IBAction func weightSettings(sender: AnyObject) {
        if open == false {
        UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
            self.subview.transform = CGAffineTransformMakeTranslation(0, 302)
            }, completion: nil)
            open = true
            weightSettings.setTitle(NSLocalizedString("Close", comment: "Скрыть"), forState: .Normal)
        } else {
            
            if menWeightField.text! != "" && womenWeightField.text! != "" {
             UIView.animateWithDuration(0.6, delay: 0, options: [], animations: {
            self.subview.transform = CGAffineTransformIdentity
                 }, completion: nil)
            open = false
            weightSettings.setTitle(NSLocalizedString("Weight settings", comment: "Параметры веса"), forState: .Normal)
                menWeight = Int(menWeightField.text!)!
                womenWeight = Int(womenWeightField.text!)!
            view.endEditing(true)
            scrollView.contentInset.bottom = 0
            } else {
                
            }
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

