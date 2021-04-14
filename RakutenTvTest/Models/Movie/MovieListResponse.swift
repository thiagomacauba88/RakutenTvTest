//
//  MovieListResponse.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 23/02/21.
//

import UIKit

struct MovieListResponse: Codable {

    var data: ContentsResponse?
}

struct ContentsResponse: Codable {
    
    var contents: ContentResponse?
}

struct ContentResponse: Codable {
    
    var data: [MovieResponse]?
}

struct MovieResponse: Codable {
    
    var id: String?
    var title: String?
    var originalTitle: String?
    var plot: String?
    var year: Int?
    var duration: Int?
    var label: String?
    var classification: ClassificationResponse?
    var images: ImagesResponse?
    var highlightedScore: HighlightedScoreResponse?
    var rating: RatingResponse?
    var scores: [ScoreResponse]?
    var orderOptions: [OrderOptionResponse]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case plot
        case year
        case duration
        case label
        case classification
        case images
        case highlightedScore = "highlighted_score"
        case rating
        case scores
        case orderOptions = "order_options"
    }
}

struct ClassificationResponse: Codable {
    
    var name: String?
    var age: Int?
}

struct ImagesResponse: Codable {
    
    var artwork: String?
    var snapshot: String?
}

struct HighlightedScoreResponse: Codable {
    
    var score: Double?
    var amountOfVotes: Int?
    var formattedAmountOfVotes: String?
    
    enum CodingKeys: String, CodingKey {
        case score
        case amountOfVotes = "amount_of_votes"
        case formattedAmountOfVotes = "formatted_amount_of_votes"
    }
}

struct RatingResponse: Codable {
    
    var average: Int?
    var scale: Int?
}

struct ScoreResponse: Codable {
    
    var score: Double?
    var formattedAmountOfVotes: String?
    
    enum CodingKeys: String, CodingKey {
        case score
        case formattedAmountOfVotes = "formatted_amount_of_votes"
    }
}

struct OrderOptionResponse: Codable {
    
    var type: String?
    var price: String
}
