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
    
    let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "IMDB"
        configSearchController()
        configCell()
    }
    
    private func configSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
    }
    
    private func configCell() {
        let nibR = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nibR, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    fileprivate func fetchMovieList(text: String) {
        let url = EndPoint.moviesList + text
        let service = Service()
        service.getMovieList(url) { (result, error) in
            if let error = error {
                print("::: Fetch MovieListError \(error)")
                self.showAlert(msg: "Error en el servicio: \(error)")
                return
            }
            self.movieListViewModel.removeAll()
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
        cell.movieImage.loadImageUsingCache(withUrl: movieListViewModel[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let st = self.getStoryBoard()
        guard let vc = st.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        searchController.searchBar.text = ""
        let movieID = self.movieListViewModel[indexPath.row].id
        vc.id = movieID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        let txt = searchController.searchBar.text?.lowercased() ?? ""
        print("::: titulo \(txt)")
        if !txt.isEmpty {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.fetchMovieList(text: txt)
            })
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}
