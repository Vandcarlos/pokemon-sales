// pokemon-sales
// Created by ___ORGANIZATIONNAME___ - Vandcarlos

import UIKit

class DetailsViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonWeakness: UILabel!
    @IBOutlet weak var pokemonSection: UILabel!
    @IBOutlet weak var pokemonPrice: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pokemonDataView: UIStackView!

    // MARK:- Properties
    var pokemonDetailsPresenter: PokemonDetailsPresenter?

    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let presenter = self.pokemonDetailsPresenter else { return }
        presenter.attachView(self)
        self.pokemonDataView.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let presenter = self.pokemonDetailsPresenter else { return }
        presenter.getPokemon()
    }

    // MARK:- UI Actions
    @IBAction func backToList(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK:- PokemonDetailsProtocol
extension DetailsViewController: PokemonDetailsProtocol {
    func startLoading() {
        self.pokemonDataView.isHidden = true
        self.activityIndicator.isHidden = false
    }

    func finishLoading() {
        self.activityIndicator.isHidden = true
        self.pokemonDataView.isHidden = false
    }

    func setPokemon(pokemon: Pokemon) {
        self.pokemonName.text = pokemon.name
        self.pokemonDescription.text = pokemon.description

        var typeLabel = NSLocalizedString("Type", comment: "")

        if pokemon.types.count != 1 {
            typeLabel = "\(typeLabel)s"
        }

        self.pokemonType.text = "\(typeLabel): \(pokemon.types.joined(separator: " - "))"

        self.pokemonWeakness.text = "\(NSLocalizedString("Weakness", comment: "")): \(String(pokemon.weakness.joined(separator: " - ")))"
        self.pokemonPrice.text = "\(NSLocalizedString("Price", comment: "")): \(String(pokemon.price))"
        self.pokemonSection.text = "\(NSLocalizedString("Section", comment: "")): \(String(pokemon.section))"

        if let image = pokemon.getImage() {
            self.pokemonImage.image = image
        }
    }
}
