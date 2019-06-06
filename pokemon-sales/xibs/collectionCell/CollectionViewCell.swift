// pokemon-sales
// Created by ___ORGANIZATIONNAME___ - Vandcarlos

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonSection: UILabel!
    @IBOutlet weak var pokemonPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }

}
