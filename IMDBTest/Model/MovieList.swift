//
//  MovieList.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import Foundation

struct MovieList: Decodable {
    var result: [Result]
}

struct Result: Decodable {
    var id: String?
    var image: String?
    var title: String?
}
