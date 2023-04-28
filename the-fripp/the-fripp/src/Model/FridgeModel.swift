//
//  FridgeModel.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import Foundation

public var addedProduct: Product?
public var productsList: [Product] = []
public var deleteStatus: Bool = true

public struct Product: Decodable {
    public let id: Int
    public let name: String
    public let bestBeforeDate: String
    public let quantity: Int
}

public struct addProduct: Decodable {
    public let name: String
    public let bestBeforeDate: String
    public let quantity: Int
}

public struct addResponse: Decodable {
    public let id: Int
    public let name: String
    public let bestBeforeDate: String
    public let quantity: Int
    public let userId: Int
    public let updatedAt: String
    public let createdAt: String
}

public struct ProductsList {
    public let products: [Product]
}

public struct ProductResponse: Decodable {
    public let product: addResponse
}

public struct AllProductsResponse: Decodable {
    public let products: [Product]
}

extension ProductsList {
    public static func getAllProducts() {
        let url = URL(string: "http://185.46.9.172:5002/api/fridge/allProducts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(curUserToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let group = DispatchGroup()
        group.enter()
        let _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                productsList = []
            }
            if let data = data {
                do {
                    let object = try JSONDecoder().decode(AllProductsResponse.self, from: data)
                    productsList = object.products
                } catch _ {
                    productsList = []
                }
            }
            group.leave()
        }.resume()
        group.wait()
    }
    
    public static func addProduct(product: addProduct) {
        let url = URL(string: "http://185.46.9.172:5002/api/fridge/product")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(curUserToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        let parameters: [String: Any] = [
            "name": product.name,
            "bestBeforeDate": product.bestBeforeDate,
            "quantity": product.quantity
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        let group = DispatchGroup()
        group.enter()
        URLSession.shared.sendData(for: request) { (result: Result<addResponse, Error>) in
            switch result {
            case .success(let response):
                addedProduct = Product(id: response.id, name: response.name, bestBeforeDate: response.bestBeforeDate, quantity: response.quantity)
            case .failure(_):
                addedProduct = nil
            }
            group.leave()
        }
        group.wait()
    }
    
    public static func deleteProduct(productId: Int) {
        deleteStatus = true
        let url = URL(string: "http://185.46.9.172:5002/api/fridge/product/\(productId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(curUserToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        let group = DispatchGroup()
        group.enter()
        let _: Void = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                deleteStatus = false
            }
            group.leave()
        }.resume()
        group.wait()
    }
}
