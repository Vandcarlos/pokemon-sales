import UIKit

struct Pokemon {
    // MARK: Properties
    let id: Int
    let name: String
    let types: [String]
    let weakness: [String]
    let description: String
    let image: String
    let sectionId: Int
    let section: String
    let price: Int64

    // MARK: Constructors
    init (pokemonDto: PokemonDto, sectionId: Int, section: String, price: Int64) {
        self.id = pokemonDto.id
        self.name = pokemonDto.name
        self.types = pokemonDto.types
        self.weakness = pokemonDto.weakness
        self.description = pokemonDto.description
        self.image = pokemonDto.image

        //Section data
        self.sectionId = sectionId
        self.section = section
        self.price = price
    }

    // MARK:- Methods
    func getImage() -> UIImage? {
        guard let imageUrl = URL(string: self.image) else { return nil }

        do {
            let imageData = try Data(contentsOf: imageUrl)
            return UIImage(data: imageData)
        } catch {
            print("Error on try image, msg: \(error)")
        }

        return nil
    }
}
