//
//  HomeCollectionViewCell.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgCardView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeId: UILabel!
    @IBOutlet weak var pokeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgCardView.layer.cornerRadius = 6
        
        self.bgCardView.layer.shadowColor = UIColor(white: 0.5, alpha: 1).cgColor
        self.bgCardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.bgCardView.layer.shadowRadius = 2
        self.bgCardView.layer.shadowOpacity = 0.25
        self.bgCardView.layer.shadowPath = UIBezierPath(roundedRect: self.bgCardView.frame, cornerRadius: 6).cgPath
        
    }
    
}
