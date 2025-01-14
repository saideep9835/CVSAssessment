//
//  APIError.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//

import Foundation

// MARK: - API Errors
// Custom errors for handling API issues.
enum APIError: Error, CustomStringConvertible {
    case badRequest
    case badResponse(statusCode: Int)
    case badURL
    case decoderError
}

extension APIError {
    var description: String {
        switch self {
        case .badRequest:
            return "Error: Bad request"
        case .badResponse(let statusCode):
            return "Error: Bad response. Status code: \(statusCode)"
        case .badURL:
            return "Error: Bad URL"
        case .decoderError:
            return "Decoder error"
        }
    }
}
