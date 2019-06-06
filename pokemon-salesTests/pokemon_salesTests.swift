// pokemon-sales
// Created by ___ORGANIZATIONNAME___ - Vandcarlos

import XCTest
@testable import pokemon_sales

class pokemon_salesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let pokemonDto = PokemonDto(id: 1, name: "Foo", types: ["Foo"], weakness: ["Foo"], description: "Foo Bar", image: "foo")

        let pokemon = Pokemon(pokemonDto: pokemonDto, sectionId: 1, section: "Foo", price: 1234)

        XCTAssertEqual(pokemon.id, pokemonDto.id)
        XCTAssertNil(pokemon.getImage())
        XCTAssertNotEqual(pokemon.name, pokemon.description)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
