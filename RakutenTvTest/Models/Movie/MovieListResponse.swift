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
    var original_title: String?
    var plot: String?
    var year: Int?
    var duration: Int?
    var label: String?
    var classification: ClassificationResponse?
    var images: ImagesResponse?
    var highlighted_score: HighlightedScoreResponse?
    var rating: RatingResponse?
    var scores: [ScoreResponse]?
    var order_options: [OrderOptionResponse]?
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
    var amount_of_votes: Int?
    var formatted_amount_of_votes: String?
}

struct RatingResponse: Codable {
    
    var average: Int?
    var scale: Int?
}

struct ScoreResponse: Codable {
    
    var score: Double?
    var formatted_amount_of_votes: String?
}

struct OrderOptionResponse: Codable {
    
    var type: String?
    var price: String
}
