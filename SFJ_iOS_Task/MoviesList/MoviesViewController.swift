//
//  ViewController.swift
//  SFJ_iOS_Task
//
//  Created by Banu Harshavardhan on 03/03/20.
//  Copyright © 2020 BanuHarshavardhan. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

   private let movieViewModel = MovieViewModel()

   @IBOutlet weak var moviesTableView: UITableView!

   override func viewDidLoad() {
      super.viewDidLoad()
      self.movieViewModel.getMovies {
         self.moviesTableView.reloadData()
      }
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
   }


}


extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.movieViewModel.numberOfRows
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let movieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
      movieTableViewCell.populateWith(self.movieViewModel.getMovie(at: indexPath.row))
      return movieTableViewCell
   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let movieId = self.movieViewModel.getMovieId(index: indexPath.row)
      self.performSegue(withIdentifier: "MovieDetail", sender: movieId)
   }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let movieDetailViewController = segue.destination as? MovieDetailViewController, let movieId = sender as? Int {
         movieDetailViewController.movieId = movieId
      }
   }

}

extension MoviesViewController: UISearchBarDelegate {

   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.resignFirstResponder()
      self.movieViewModel.searchMoviesHaving(searchText: "")
      self.moviesTableView.reloadData()
   }

   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      self.movieViewModel.searchMoviesHaving(searchText: searchText)
      self.moviesTableView.reloadData()
   }

   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.resignFirstResponder()
   }

}
