//
//  DetailImageTableViewCell.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 19/10/21.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
