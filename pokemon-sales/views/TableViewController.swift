// pokemon-sales
// Created by ___ORGANIZATIONNAME___ - Vandcarlos

import Foundation
import UIKit

class TableViewController: UIViewController {

    // MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // MARK:- Properties
    private let pokemonListPresenter = PokemonListPresenter()
    private var pokemonList = [Pokemon]()

    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonListPresenter.attachView(self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        self.activityIndicator.startAnimating()
        self.pokemonListPresenter.getPokemons()
    }
}

// MARK:- PokemonListProtocol
extension TableViewController: PokemonListProtocol {
    func setEmptyList() {
        self.noDataLabel.isHidden = false
    }

    func onPokemonIsClicked(detailsViewController: DetailsViewController) {
        self.present(detailsViewController, animated: true, completion: nil)
    }

    func startLoading() {
        self.tableView.isHidden = true
        self.noDataLabel.isHidden = true
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }

    func finishLoading() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }

    func setPokemonList(pokemonList: [Pokemon]) {
        self.pokemonList = pokemonList
        self.tableView.reloadData()
        self.tableView.isHidden = false
    }
}

// MARK:- UITableViewDelegate
extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storyboard = self.storyboard else { return }
        let pokemon = self.pokemonList[indexPath.row]
        self.pokemonListPresenter.pokemonClick(storyboard: storyboard, pokemon: pokemon)
    }
}

// MARK:- UITableViewDataSource
extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        let pokemon = self.pokemonList[indexPath.row]

        cell.pokemonName.text = pokemon.name
        cell.pokemonPrice.text = "\(NSLocalizedString("Price", comment: "")): \(String(pokemon.price))"
        cell.pokemonSection.text = "\(NSLocalizedString("Section", comment: "")): \(String(pokemon.section))"
        cell.pokemonType.text = "\(NSLocalizedString("Type", comment: "")): \(String(pokemon.types.joined(separator: " - ")))"

        if let image = pokemon.getImage() {
            cell.pokemonImage.image = image
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 200 : 300
    }
}
