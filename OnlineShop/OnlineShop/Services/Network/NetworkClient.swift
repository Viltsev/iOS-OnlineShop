//
//  NetworkClient.swift
//  OnlineShop
//
//  Created by Данила on 25.03.2024.
//

import Foundation
import Combine
import Dependencies

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

struct NetworkClient: Equatable {
    func signUp(request: SignUpRequest) async throws -> Data {
        guard let url = URL(string: "http://localhost:8080/api/v1/auth/sign-up") else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        return data
    }
    
    func signIn(request: SignInRequest) async throws -> Data {
        guard let url = URL(string: "http://localhost:8080/api/v1/auth/sign-in") else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        return data
    }
}
