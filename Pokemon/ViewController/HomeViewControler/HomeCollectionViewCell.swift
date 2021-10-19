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
        
        let cornerRadius: CGFloat = 6
        
        self.bgCardView.layer.cornerRadius = cornerRadius
        
        self.bgCardView.layer.shadowColor = UIColor(white: 0.5, alpha: 1).cgColor
        self.bgCardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.bgCardView.layer.shadowRadius = 2
        self.bgCardView.layer.shadowOpacity = 0.25
        self.bgCardView.layer.shadowPath = UIBezierPath(roundedRect: self.bgCardView.frame, cornerRadius: cornerRadius).cgPath
        
        // Round only imageView TopLeft and TopRight.
        let path = UIBezierPath(roundedRect: self.pokeImageView.frame,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.pokeImageView.layer.mask = mask
        
    }
    
    func animatedHideShadow() {
        
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
         animation.fromValue = self.bgCardView.layer.shadowOpacity
         animation.toValue = 0.1
         animation.duration = 0.15
        self.bgCardView.layer.add(animation, forKey: animation.keyPath)
        self.bgCardView.layer.shadowOpacity = 0.1
    }
    
    func animatedShowShadow() {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
         animation.fromValue = self.bgCardView.layer.shadowOpacity
         animation.toValue = 0.25
         animation.duration = 0.05
        self.bgCardView.layer.add(animation, forKey: animation.keyPath)
        self.bgCardView.layer.shadowOpacity = 0.25
    }
}
