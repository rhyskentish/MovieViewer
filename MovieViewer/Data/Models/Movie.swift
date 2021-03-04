//
//  Movie.swift
//  MovieViewer
//
//  Created by Rhys Kentish on 02/03/2021.
//

import Foundation

struct Movie: Codable {
    let id: String
    let rank: String
    let imDbRating: String
    let fullTitle: String
    let title: String
    let image: String
    let crew: String
}
