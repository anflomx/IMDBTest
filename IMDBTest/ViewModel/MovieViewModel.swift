//
//  MovieViewModel.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import Foundation

struct MovieViewModel {
    var id: String?
    var image: String?
    var title: String?
    var year: String?
    var genres: String?
    var countries: String?
    var plot: String?
    var directors: String?
    
    init(movie: Movie) {
        self.id = movie.id ?? ""
        self.image = movie.image ?? ""
        self.title = movie.title ?? ""
        self.year = movie.year ?? ""
        self.genres = movie.genres ?? ""
        self.countries = movie.countries ?? ""
        self.plot = movie.plot ?? ""
        self.directors = movie.directors ?? ""
    }
}
