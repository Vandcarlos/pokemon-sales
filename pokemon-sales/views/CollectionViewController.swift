// pokemon-sales
// Created by ___ORGANIZATIONNAME___ - Vandcarlos

import UIKit

class CollectionViewController: UIViewController {

    // MARK:- Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // MARK:- Properties
    private let pokemonListPresenter = PokemonListPresenter()
    private var pokemonList = [Pokemon]()

    // MARK:- Lify cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonListPresenter.attachView(self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isHidden = true
        self.noDataLabel.isHidden = true
        self.collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
        self.activityIndicator.startAnimating()
        self.pokemonListPresenter.getPokemons()
    }
}

// MAKR:- PokemonListProtocol
extension CollectionViewController: PokemonListProtocol {
    func setEmptyList() {
        self.noDataLabel.isHidden = false
    }

    func onPokemonIsClicked(detailsViewController: DetailsViewController) {
        self.present(detailsViewController, animated: true, completion: nil)
    }

    func startLoading() {
        self.collectionView.isHidden = true
        self.activityIndicator.isHidden = false
        self.noDataLabel.isHidden = true
        self.activityIndicator.startAnimating()
    }

    func finishLoading() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }

    func setPokemonList(pokemonList: [Pokemon]) {
        self.pokemonList = pokemonList
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
    }
}

// MARK:- UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let storyboard = self.storyboard else { return }
        let pokemon = self.pokemonList[indexPath.row]
        self.pokemonListPresenter.pokemonClick(storyboard: storyboard, pokemon: pokemon)
    }
}

// MARK:- UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! CollectionViewCell

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
}
