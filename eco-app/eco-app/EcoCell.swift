//
//  EcoCell.swift
//  eco-app
//
//  Created by Avanti Manjunath on 11/17/23.
//

import UIKit

class EcoCell: UITableViewCell {

    
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var numericValueLabel: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
