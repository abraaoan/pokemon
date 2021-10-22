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
    
    let services = Services.shared
    
    var results: [ResultViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinnerView.isHidden = false
        
        services.getPokemons { [weak self] pokemos, hasError in
            if !hasError {
                self?.results = pokemos
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.spinnerView.isHidden = true
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func shouldLoadMoreResults(_ indexPath:IndexPath ) -> Bool {
        
        guard let quantity = results?.count else { return false }
        if quantity == 0 { return false }
        
        if indexPath.row == (quantity - 3) {
            return true
        } else {
            return false
        }
    }
    
    func loadNextResult() {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
            self?.services.getMorePokemons { [weak self] pokemos, hasError in
                if !hasError {
                    pokemos?.forEach({ self?.results?.append($0) })
                    DispatchQueue.main.async { [weak self] in
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
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
            cell.pokeImageView.getImage(url: url)
        }
        
        // Favorite icons
        if let id = poke.pokemon?.id {
            cell.icLikeView.isHidden = !Favorite.shared.isFavorite(id: "\(id)")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.shouldLoadMoreResults(indexPath) {
            self.loadNextResult()
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailViewController")
        
        if let vc = viewController as? DetailViewController {
            guard let poke = results?[indexPath.row] else { return }
            
            vc.pokemon = poke.pokemon
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
