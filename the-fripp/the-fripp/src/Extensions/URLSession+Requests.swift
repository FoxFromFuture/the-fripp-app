//
//  URLSession+Requests.swift
//  the-fripp
//
//  Created by Никита Лисунов on 23.04.2023.
//

import UIKit

extension URLSession {
    func sendData<T: Decodable>(for request: URLRequest, completion: @escaping (Result<T, Error>) -> ()) {
        self.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
