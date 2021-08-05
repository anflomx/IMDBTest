//
//  HomeViewController.swift
//  IMDBTest
//
//  Created by Antonio Flores on 05/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var movieListViewModel = [MovieListViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configCell()
        fetchMovieList()
    }
    
    private func configCell() {
        let nibR = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nibR, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    fileprivate func fetchMovieList() {
        let service = Service()
        //
        service.getMovieList(EndPoint.moviesList) { (result, error) in
            if let error = error {
                print("::: Fetch MovieListError \(error)")
                //
                return
            }
            
            let movieList = result?.results.map({return  MovieListViewModel(result: $0)}) ?? []
            movieList.forEach { movie in self.movieListViewModel.append(movie) }
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.movieTitleLabel?.text = movieListViewModel[indexPath.row].title
        return cell
    }
}
