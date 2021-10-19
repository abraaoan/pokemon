//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Abraao Nascimento on 19/10/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pokemon: Pokemon? {
        didSet {
            self.title = pokemon?.name?.capitalized
        }
    }
    let favorite = Favorite.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Clear tableView separator
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        //
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func identifier(section: Int) -> String {
        return section == 0 ? "DetailImageTableViewCell" : "DetailPropertiesTableViewCell"
    }
    
    func height(section: Int) -> CGFloat {
        
        let screen = UIScreen.main.bounds
        let imageHeight =  UIDevice.current.orientation.isLandscape ? screen.height : screen.width
        
        return section == 0 ? imageHeight : 214
    }
    
    @IBAction func like() {
        if let id = pokemon?.id {
            
            if self.favorite.isFavorite(id: "\(id)") {
                self.favorite.remove(id: "\(id)")
            } else {
                self.favorite.add(id: "\(id)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier(section: indexPath.section))
        
        if indexPath.section == 0 {
            
            // Big Beauty image cell.
            
            guard let cell = cell as? DetailImageTableViewCell else { return cell ?? UITableViewCell() }
            
            if let id = pokemon?.id {
                
                let isFavorite = self.favorite.isFavorite(id: "\(id)")
                let normal = isFavorite ? #imageLiteral(resourceName: "btnLikeHi") : #imageLiteral(resourceName: "btnLike")
                let high = isFavorite ? #imageLiteral(resourceName: "btnLike") : #imageLiteral(resourceName: "btnLikeHi")
                
                cell.btnLike.setImage(normal, for: .normal)
                cell.btnLike.setImage(high, for: .highlighted)
                
            }
            
            if let imageUrl = pokemon?.sprites?.other?.official_artwork?.front_default,
               let url = URL(string: imageUrl) {
                Services.shared.downloadImage(url: url) { image, data in
                    DispatchQueue.main.async {
                        cell.pokeImageView.image = image
                    }
                }
            }
            
            return cell
            
        } else {
            
            // Properties.
            guard let cell = cell as? DetailPropertiesTableViewCell else { return cell ?? UITableViewCell() }
         
            cell.lblHeight.text  = "\(pokemon?.height ?? 0)"
            cell.lblWeight.text  = "\(pokemon?.weight ?? 0)"
            cell.lblSpecies.text = "-"
            cell.lblType.text    = pokemon?.types?.first?.type.name
            cell.lblAbility.text = pokemon?.abilities?.first?.ability.name
            cell.lblNumber.text  = "\(pokemon?.id ?? 0)"
            
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.height(section: indexPath.section)
    }
    
}
