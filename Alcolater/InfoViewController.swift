//
//  InfoViewController.swift
//  Alcolater
//
//  Created by To Glory! on 16/05/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    let locale = NSLocale.preferredLanguages().first!
    let screenHeight: Int = Int(UIScreen.mainScreen().bounds.size.height)
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageEn = UIImage(named: "Help_ENG")
        let imageRu = UIImage(named: "Help_RUS")
        let imageRu4s = UIImage(named: "Help_4S_RUS")
        let imageEn4s = UIImage(named: "Help_4S_ENG")
        if screenHeight == 480 {
            if locale.hasPrefix("ru") {
                imageView.image = imageRu4s
            } else {
                imageView.image = imageEn4s
            }
        } else {
            if locale.hasPrefix("ru") {
            imageView.image = imageRu
            } else {
                imageView.image = imageEn
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backGesture(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   

}
