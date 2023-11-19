// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public class NetworkManager {
    public init() {}

    public func fetchData<T: Decodable>(from url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseData = data else {
                let error = NSError(domain: "NoData", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

