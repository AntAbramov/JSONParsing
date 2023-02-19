import UIKit

struct ApiUrl {
    static let givenLink = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
}

enum ApiErrors: Error {
    case invalidUrl
    case decodingFailed
    case invalidData
}

class NetworService {
    
    func obtainData(urlString: String, completion: @escaping (Result<Company, ApiErrors>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            if let model = try? JSONDecoder().decode(Company.self, from: data) {
                completion(.success(model))
            } else {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
    
}
