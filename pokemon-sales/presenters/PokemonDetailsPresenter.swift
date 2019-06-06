// pokemon-sales
// Created by ___ORGANIZATIONNAME___ - Vandcarlos

import Foundation

protocol PokemonDetailsProtocol {
    func startLoading()
    func finishLoading()
    func setPokemon(pokemon: Pokemon)
}

class PokemonDetailsPresenter {
    // MARK:- Properties
    var view: PokemonDetailsProtocol?
    let pokemon: Pokemon

    // MARK:- Constructors
    init (pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    // MARK: Methods
    func attachView(_ view: PokemonDetailsProtocol) {
        self.view = view
    }

    func getPokemon() {
        guard let view = self.view else {
            fatalError("View is not set")
        }

        view.startLoading()
        view.setPokemon(pokemon: self.pokemon)
        view.finishLoading()
    }
}
