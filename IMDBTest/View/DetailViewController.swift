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
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovie()
    }
    
    fileprivate func fetchMovie() {
        let url = EndPoint.movie + id
        let service = Service()
        //
        service.getMovie(url) { (result, error) in
            if let error = error {
                print("::: Fetch MovieError \(error)")
                //
                return
            }
            self.movie = result
            print(self.movie!)
        }
    }
}
