//
//  MovieDetailViewModel.swift
//  SFJ_iOS_Task
//
//  Created by Banu Harshavardhan on 03/03/20.
//  Copyright © 2020 BanuHarshavardhan. All rights reserved.
//

import UIKit

class MovieDetailViewModel {

   var movieDetailResponse: MovieDetailResponse?

   func getMovieDetails(movieId: Int, completion: @escaping () -> ()) {
      ServiceManager.shared.getFrom(urlComponent: movieId.description, decodeType: MovieDetailResponse.self) { (decoded) in
         self.movieDetailResponse = decoded
         completion()
      }
   }

}
