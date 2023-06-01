//
//  MainTableViewCell.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/1.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var enterLabel1: UILabel!
    @IBOutlet weak var enterLabel2: UILabel!
    @IBOutlet weak var enterLabel3: UILabel!
    @IBOutlet weak var enterLabel4: UILabel!
    
    @IBOutlet weak var hintLabel1: UILabel!
    @IBOutlet weak var hintLabel2: UILabel!
    @IBOutlet weak var hintLabel3: UILabel!
    @IBOutlet weak var hintLabel4: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        enterLabel1.text = ""
        enterLabel2.text = ""
        enterLabel3.text = ""
        enterLabel4.text = ""
        hintLabel1.text = ""
        hintLabel3.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
