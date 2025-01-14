//
//  APIManager.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//
import Foundation

// MARK: - API Protocol
protocol ApiProtocol{
    func getData<T: Codable>(url: URL) async throws -> T
}

// MARK: - API Manager
class APIManager: ApiProtocol{
    
    // MARK: - Singleton Instance
    // The shared instance of `APIManager`.
    static let shared = APIManager()
    private init() { }
    
    // MARK: - API Protocol Implementation
    func getData<T: Codable>(url: URL) async throws -> T{
        let (data,response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{throw APIError.badResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        do{
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        }catch{
            throw APIError.decoderError
        }
    }
}
