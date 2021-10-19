//
//  ViewController.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 18/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinnerView: UIView!
    
    var results: [ResultViewModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.spinnerView.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.spinnerView.isHidden = false
        let services = Services()
        
        services.getPokemons { pokemos, hasError in
            self.results = pokemos
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        guard let poke = results?[indexPath.row] else { return cell }
        cell.pokeName.text = poke.name
        cell.pokeId.text = poke.pokeId
        
        if let url = poke.mainImage {
            Services.shared.downloadImage(url: url) { image, data in
                DispatchQueue.main.async {
                    cell.pokeImageView.image = image
                }
            }
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView .cellForItem(at: indexPath) as! HomeCollectionViewCell
        cell.animatedHideShadow()
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView .cellForItem(at: indexPath) as! HomeCollectionViewCell
        cell.animatedShowShadow()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        /*
            Don't do this at home.
            Basically I did the math, screen size divide by cardSize.
            I create the minSpace for avoid too short margin.
         */
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cardWidth: CGFloat = 96
        let minSpace: CGFloat = 20
        
        let howManyCards = floor(screenWidth / (cardWidth + minSpace))
        let spaces = howManyCards + 1
        
        let margin = (screenWidth - (cardWidth * howManyCards)) / spaces
        
        return UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
    }
    
}
