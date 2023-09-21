//
//  MovieModel.swift
//  canerDeneme3
//
//  Created by Caner Özcan on 19.09.2023.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id = UUID()
    let title: String
    let posterPath: String
    let overview: String
    let popularity: Double
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}


struct MovieResponse: Codable {
    let results: [Movie]
}
