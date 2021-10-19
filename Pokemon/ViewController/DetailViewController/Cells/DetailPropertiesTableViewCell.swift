//
//  DetailPropertiesTableViewCell.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 19/10/21.
//

import UIKit

class DetailPropertiesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAbility: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
