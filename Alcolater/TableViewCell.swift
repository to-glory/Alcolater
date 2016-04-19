//
//  TableViewCell.swift
//  Alcolater
//
//  Created by To Glory! on 16/04/16.
//  Copyright © 2016 Nerd trio. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet var title: UILabel!
    @IBOutlet var value: UITextField!
    @IBOutlet var volume: UILabel!
    @IBOutlet var switcher: UISwitch!
    
    @IBAction func switched(sender: AnyObject) {
        if switcher.on == true {
            value.enabled = true
        } else {
            value.enabled = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
