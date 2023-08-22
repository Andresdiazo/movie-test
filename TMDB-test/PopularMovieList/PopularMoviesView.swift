//
//  PopularMoviesView.swift
//  TMDB-test
//
//  Created by Andres Diaz  on 11/05/23.
//


import UIKit

class PopularMoviesView: UIViewController {
    var presenter: popularMoviesPresenter?
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var array: [Movies]?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewAppear()
        
        
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "myCell")

    }
}
extension PopularMoviesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MovieCell else {
            fatalError("No se pudo obtener la celda personalizada.")
        }
        cell.titleMovieLabel.text = self.array?[indexPath.row].title
        cell.descriptionMovieLabel.text = self.array?[indexPath.row].overview
        
        if let urlString = self.array?[indexPath.row].posterPath as? String {
            ImageHelper.loadImage(from: urlString) { image in
                cell.movieImageView.image = image
            }
        }
        return cell
    }
}

extension PopularMoviesView: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        //  if let query = searchController.searchBar.text {
        
        //}
    }
}

extension PopularMoviesView: ListOfPopularMovies {
    func update(results: [Movies]?) {
        if let data = results {
                    array = data
                }
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
    }
}
//extension PopularMoviesView: NetworServiceDelegate {
//    func getResults(results: [Movie]?) {
//        if let data = results {
//            array = data
//        }
//        DispatchQueue.main.async {
//            self.tableView.delegate = self
//            self.tableView.dataSource = self
//            self.tableView.reloadData()
//        }
//    }
//}

