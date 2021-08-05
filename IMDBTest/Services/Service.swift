//
//  Service.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import Foundation


class Service: NSObject {
    static let shared = Service()
    
    func getMovieList(_ urlMovies: String, completion: @escaping (MovieList?, Error?) -> ()) {
        guard let url = URL(string: urlMovies) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                print("::: Error en servicio \(error)")
                return
            }
            
            guard let json = data else { return }
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: json)
                DispatchQueue.main.async {
                    completion(movieList, nil)
                }
            } catch let jsonError {
                print("::: Error decode \(jsonError)")
            }
        }.resume()
    }
    
    func getMovie(_ urlMovie: String, completion: @escaping (Movie?, Error?) -> ()) {
        guard let url = URL(string: urlMovie) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                print("::: Error en servicio \(error)")
                return
            }
            
            guard let json = data else { return }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: json)
                DispatchQueue.main.async {
                    completion(movie, nil)
                }
            }catch let jsonError {
                print("::: Error decode \(jsonError)")
            }
        }.resume()
    }
}
