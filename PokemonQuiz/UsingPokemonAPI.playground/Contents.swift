import UIKit


// MARK: - Código para usar la Pokemon API

// Datos en bruto recibidos desde la API
struct PokemonData: Codable {
    let results: [Result]?
}

// Formato de los datos recibidos o resultados
struct Result: Codable {
    let name: String?
    let url: String?
}

// Datos con los que vamos a trabajar, lo que nos interesa de todo lo recibido
struct PokemonModel {
    let name: String
    let imageURL: String
}

protocol PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel])
    func didFailWithError(error: Error)
}

struct PokemonManager {
    let pokemonURL = "https://pokeapi.co/api/v2/pokemon?limit=898"
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemon() {
        performRequest(with: pokemonURL)
    }
    
    private func performRequest(with urlString: String) {
        // 1. Create/get URL
        if let url = URL(string: urlString) {
            // 2. Create the URLSession
            let session = URLSession(configuration: .default)
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData) {
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    private func parseJSON(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodedData.results?.map {
                PokemonModel(name: $0.name ?? "", imageURL: $0.url ?? "")
            }
            return pokemon
        } catch {
            return nil
        }
    }
}


// Ejemplo de ViewController de UIKit con storyboards

class PokemonViewController: UIViewController {
    var pokemonManager = PokemonManager()
    var randomPokemon: [PokemonModel] = []
    var correctAnswer: String = ""
    var correctAnswerImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        
        pokemonManager.fetchPokemon()
    }
}

extension PokemonViewController: PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        randomPokemon = pokemons.choose(4)
        let index = Int.random(in: 0...3)
        let imageData = randomPokemon[index].imageURL
        correctAnswer = randomPokemon[index].name
        
        imageManager.fetch
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// Extensión para no trabajar con el array completo de 900 pokemon, sino elegir 4 al azar

extension Collection where Indices.Iterator.Element == Index {
    // Cómo elegir un índice dentro de nuestra colección, que no se pase de los límites
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
extension Collection {
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
