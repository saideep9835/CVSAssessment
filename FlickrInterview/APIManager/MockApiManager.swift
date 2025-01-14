//
//  MockApiManager.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//

import Foundation

class MockApiManager: ApiProtocol{
    func getData<T: Codable>(url: URL) async throws -> T {
        
        let mockItems = [
            Items(
                title: "Mock Title 1",
                link: "https://example.com/image1",
                media: FlickerMedia(m: "https://via.placeholder.com/150"),
                dateTaken: "2024-10-14T10:00:00Z",
                description: "Mock Description 1",
                published: "2024-10-14T14:30:00Z",
                author: "Mock Author 1",
                authorId: "12345",
                tags: "mock, sample"
            ),
            Items(
                title: "Mock Title 2",
                link: "https://example.com/image2",
                media: FlickerMedia(m: "https://via.placeholder.com/150"),
                dateTaken: "2024-10-14T11:00:00Z",
                description: "Mock Description 2",
                published: "2024-10-14T15:30:00Z",
                author: "Mock Author 2",
                authorId: "67890",
                tags: "test, flickr"
            )
        ]
        
        let mockFlicrModel = FlicrModel(
            title: "Mock Flickr Feed",
            link: "https://example.com",
            description: "This is a mock Flickr feed for testing purposes.",
            modified: "2024-10-14T16:00:00Z",
            generator: "Mock Generator",
            items: mockItems
        )
        
        // Ensure the type matches the expected type `T`
        guard let result = mockFlicrModel as? T else {
            throw NSError(domain: "MockAPIManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid type"])
        }
        
        return result
    }
}
    
    

