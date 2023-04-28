//
//  UserModel.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import Foundation

public var curUserToken: String = ""
public var curStatus: Bool = false

public struct User: Decodable {
    public let email: String
    public let password: String
}

public struct Response: Decodable {
    public let token: String
}

extension User {
    public static func signInUser(user: User) {
        let url = URL(string: "http://185.46.9.172:5002/api/user/signIn")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "email": user.email,
            "password": user.password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        let group = DispatchGroup()
        group.enter()
        URLSession.shared.sendData(for: request) { (result: Result<Response, Error>) in
            switch result {
            case .success(let response):
                curStatus = true
                curUserToken = response.token
            case .failure(_):
                curStatus = false
            }
            group.leave()
        }
        group.wait()
    }
    
    public static func signUpUser(user: User) {
        let url = URL(string: "http://185.46.9.172:5002/api/user/signUp")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpMethod = "PUT"
        let parameters: [String: Any] = [
            "email": user.email,
            "password": user.password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        let group = DispatchGroup()
        group.enter()
        URLSession.shared.sendData(for: request) { (result: Result<Response, Error>) in
            switch result {
            case .success(let response):
                curStatus = true
                curUserToken = response.token
            case .failure(_):
                curStatus = false
            }
            group.leave()
        }
        group.wait()
    }
}
