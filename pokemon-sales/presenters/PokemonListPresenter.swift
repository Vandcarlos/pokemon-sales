import Foundation
import UIKit

protocol PokemonListProtocol {
    func startLoading()
    func finishLoading()
    func setPokemonList(pokemonList: [Pokemon])
    func onPokemonIsClicked(detailsViewController: DetailsViewController)
    func setEmptyList()
}

class PokemonListPresenter {

    //MARK:- Properties
    let pokemonService: PokemonService
    var view: PokemonListProtocol?

    // MARK:- Constructors
    init () {
        self.pokemonService = PokemonService()
    }

    // MARK:- Methods
    func attachView(_ view: PokemonListProtocol) {
        self.view = view
    }

    func getPokemons() {
        guard let view = self.view else {
            fatalError("View is not set")
        }

        view.startLoading()

        DispatchQueue.main.async {
            self.pokemonService.callApiToGetPokemons(
                onSuccess: { (pokemonList) in
                    view.setPokemonList(pokemonList: pokemonList)
                    view.finishLoading()
            },
                onError: {
                    print("Error on get pokemons")
                    view.finishLoading()
                    view.setEmptyList()
            })
        }
    }

    func pokemonClick (storyboard: UIStoryboard, pokemon: Pokemon) {
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "detailsViewController") as? DetailsViewController else {
            return
        }

        detailsViewController.pokemonDetailsPresenter = PokemonDetailsPresenter(pokemon: pokemon)

        view?.onPokemonIsClicked(detailsViewController: detailsViewController)
    }
}
