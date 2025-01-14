//
//  FlicrModel.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 10/14/24.
//
import Foundation

struct FlicrModel: Codable, Hashable{
    let title: String?
    let link: String?
    let description: String?
    let modified: String?
    let generator: String?
    let items: [Items]?
}

struct Items: Codable, Hashable{
    let title: String?
    let link: String?
    let media: FlickerMedia?
    let dateTaken: String?
    let description: String?
    let published: String?
    let author: String?
    let authorId: String?
    let tags: String?
    
    enum CodinKeys: String, CodingKey{
        case title = "title"
        case link = "link"
        case media = "media"
        case dateTaken = "date_taken"
        case description = "description"
        case published = "published"
        case author = "author"
        case authorId = "author_id"
        case tags = "tags"
    }
}

struct FlickerMedia: Codable, Hashable{
    let m: String?
}
