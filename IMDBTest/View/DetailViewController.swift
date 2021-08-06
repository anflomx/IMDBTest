//
//  DetailViewController.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieGender: UILabel!
    @IBOutlet weak var movieCountry: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail IMDB"
        fetchMovie()
    }
    
    private func fetchMovie() {
        let url = EndPoint.movie + id
        let service = Service()
        self.showSpinner(onView: self.view)
        service.getMovie(url) { (result, error) in
            if let error = error {
                print("::: Fetch MovieError \(error)")
                self.showAlert(msg: "Error en el servicio: \(error)")
                self.removeSpinner()
                return
            }
            let movieInfo = result.map({return MovieViewModel(movie: $0)})
            
            guard let mov = movieInfo else { return }
            self.fillInfo(movie: mov)
            self.removeSpinner()
        }
    }
    
    private func fillInfo(movie: MovieViewModel) {
        movieImage.loadImageUsingCache(withUrl: movie.image ?? "")
        movieTitle.text = "Título: \(movie.title ?? "")"
        movieYear.text = "Año: \(movie.year ?? "")"
        movieGender.text = "Genero: \(movie.genres ?? "")"
        movieCountry.text = "País: \(movie.countries ?? "")"
        moviePlot.text = "Sinopsis: \(movie.plot ?? "")"
        movieDirector.text = "Director: \(movie.directors ?? "")"
    }
}
