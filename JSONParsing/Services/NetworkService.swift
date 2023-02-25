import UIKit

struct ApiUrl {
    static let givenLink = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
}

enum ApiErrors: Error {
    case invalidUrl
    case decodingFailed
    case invalidData
    case requestFailed
}

class NetworService {
    
    func obtainData(urlString: String, completion: @escaping (Result<Company, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiErrors.invalidUrl))
            return
        }
        let request = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            if let model = decode(data: cachedResponse.data) {
                completion(.success(model))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(ApiErrors.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ApiErrors.requestFailed))
                return
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let model = self.decode(data: data) {
                let cached = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cached, for: request)
                URLCache.shared.removeCachedResponses(since: Date(timeIntervalSinceNow: TimeInterval(3600000)))
                completion(.success(model))
            } else {
                completion(.failure(ApiErrors.decodingFailed))
            }
        }
        task.resume()
    }
    
    //Декод
    private func decode(data: Data) -> Company? {
        if let model = try? JSONDecoder().decode(Company.self, from: data) {
            return model
        }
        return nil
    }
    
}
