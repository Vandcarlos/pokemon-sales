import Alamofire

class PokemonService {
    static let url = "https://private-a37d8e-pokestorm.apiary-mock.com/pokemons"

    func callApiToGetPokemons(onSuccess: @escaping ((_ pokemonList: [Pokemon]) -> Void), onError: @escaping (() -> Void) ) {
        Alamofire.request(PokemonService.url)
            .responseJSON { (response) in

                switch response.result {
                case .success( _):
                    guard let data = response.data, let str = String(data: data, encoding: .utf8) else {
                        print("Not cast")
                        onError()
                        return
                    }

                    let jsonData = str.data(using: .utf8)!
                    let decoder = JSONDecoder()

                    let pokemonSectionListDto: [PokemonSectionDto]

                    do {
                        pokemonSectionListDto = try decoder.decode([PokemonSectionDto].self, from: jsonData)
                    } catch {
                        print(error)
                        onError()
                        return
                    }

                    var pokemon = [Pokemon]()

                    for pokemonSectionDto in pokemonSectionListDto {
                        for pokemonDto in pokemonSectionDto.pokemons {
                            pokemon.append(Pokemon(pokemonDto: pokemonDto, sectionId: pokemonSectionDto.id, section: pokemonSectionDto.section, price: pokemonSectionDto.price))
                        }
                    }

                    onSuccess(pokemon)

                case .failure(let error):
                    print(error)
                    onError()
                }
        }
    }
}
