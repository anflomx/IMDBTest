//
//  MovieListViewModel.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import Foundation

struct MovieListViewModel {
    var id: String
    var image: String
    var title: String
    
    init(result: Result) {
        self.id = result.id ?? ""
        self.image = result.image ?? ""
        self.title = result.title ?? ""
    }
}
