//
//  Movie.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import Foundation

struct Movie: Decodable {
    var id: String?
    var image: String?
    var title: String?
    var year: String?
    var genres: String?
    var countries: String?
    var plot: String?
    var directors: String?
}

