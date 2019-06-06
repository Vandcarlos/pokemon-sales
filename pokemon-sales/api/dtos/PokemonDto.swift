struct PokemonDto: Codable {
    let id: Int
    let name: String
    let types: [String]
    let weakness: [String]
    let description: String
    let image: String
}

struct PokemonSectionDto: Codable {
    let id: Int
    let section: String
    let price: Int64
    var pokemons = [PokemonDto]()
}
