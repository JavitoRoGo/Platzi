//
//  Model.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 17/3/23.
//

import Foundation

// MARK: - EndPoints

struct Endpoints {
    static let domain = "https://platzi-tweets-backend.herokuapp.com/api/v1"
    static let login = Endpoints.domain + "/auth"
    static let register = Endpoints.domain + "/register"
    static let getPosts = Endpoints.domain + "/post"
    static let post = Endpoints.domain + "/post"
    static let delete = Endpoints.domain + "/post/"
}

// MARK: - Login and Register

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let user: User
    let token: String
}

struct ErrorResponse: Codable {
    let error: String
}

struct User: Codable {
    let email: String
    let names: String
    let nickname: String
}

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let names: String
}

// MARK: - Obtener tweets

struct PostRequest: Codable {
    let text: String
    let imageUrl: String?
    let videoUrl: String?
    let location: PostRequestLocation?
}

struct PostRequestLocation: Codable {
    let latitude: Double
    let longitude: Double
}

struct Post: Codable {
    let id: String
    let author: User
    let imageUrl: String
    let text: String
    let videoUrl: String
    let location: PostLocation
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}

struct PostLocation: Codable {
    let latitude: Double
    let longitude: Double
}

struct GeneralResponse: Codable {
    let isDone: Bool
    let message: String
}
