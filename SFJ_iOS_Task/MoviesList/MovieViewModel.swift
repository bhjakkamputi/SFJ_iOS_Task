//
//  MovieViewModel.swift
//  SFJ_iOS_Task
//
//  Created by Banu Harshavardhan on 03/03/20.
//  Copyright © 2020 BanuHarshavardhan. All rights reserved.
//

import UIKit

class MovieViewModel {

   private var moviesResponse: MoviesResponse? {
      didSet {
         self.moviesList = self.moviesResponse?.results ?? []
      }
   }

   private var moviesList: [Result] = []

   var numberOfRows: Int {
      return self.moviesList.count
   }

   func getMovies(completionHandler: @escaping () -> ()) {
      
      ServiceManager.shared.getFrom(urlComponent: "popular", decodeType: MoviesResponse.self) { (decoded) in
         self.moviesResponse = decoded
         completionHandler()
      }
      
   }

   func getMovieId(index: Int) -> Int {
      return self.moviesList[index].id
   }

   func getMovie(at index: Int) -> Result? {
      return self.moviesList[index]
   }

   func searchMoviesHaving(searchText: String) {
      if searchText.isEmpty {
         self.moviesList = self.moviesResponse?.results ?? []
      } else {
         self.moviesList = self.moviesResponse?.results.filter({ $0.title.contains(searchText) }) ?? []
      }

   }

}
