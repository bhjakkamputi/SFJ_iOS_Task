//
//  MovieDetailViewController.swift
//  SFJ_iOS_Task
//
//  Created by Banu Harshavardhan on 03/03/20.
//  Copyright © 2020 BanuHarshavardhan. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

   @IBOutlet weak var movieImageView: UIImageView!
   @IBOutlet weak var movieTitleLabel: UILabel!
   @IBOutlet weak var movieDurationLabel: UILabel!
   @IBOutlet weak var movieReleaseDateLabel: UILabel!
   @IBOutlet weak var movieLanguagesLabel: UILabel!
   @IBOutlet weak var movieGenresLabel: UILabel!
   @IBOutlet weak var movieRatingLabel: UILabel!
   @IBOutlet weak var aboutMovieLabel: UILabel!
   @IBOutlet weak var movieCastLabel: UILabel!

   var movieId: Int = 0

   private let movieDetailViewModel = MovieDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
      self.movieDetailViewModel.getMovieDetails(movieId: self.movieId) {
         self.populateMovieDetails()
      }
    }

   private func populateMovieDetails() {
      let movieDetails = self.movieDetailViewModel.movieDetailResponse
      self.movieTitleLabel.text = movieDetails?.title
      self.movieDurationLabel.text = (movieDetails?.runtime?.description ?? "") + " Minutes"
      self.movieReleaseDateLabel.text = movieDetails?.releaseDate
      self.movieLanguagesLabel.text = movieDetails?.spokenLanguages?.compactMap({ $0.name }).joined(separator: ", ")
      self.movieGenresLabel.text = movieDetails?.genres?.compactMap({ $0.name }).joined(separator: ", ")
      self.movieRatingLabel.text = (movieDetails?.voteAverage?.description ?? "") + " & " + (movieDetails?.voteCount?.description ?? "") + " votes"

      self.aboutMovieLabel.text = movieDetails?.overview
      // self.movieCastLabel.text = movieDetails?.overview

      DispatchQueue.global(qos: .userInitiated).async {
         let imageBaseUrl = "http://image.tmdb.org/t/p/w185"
         if let imageUrlText = movieDetails?.backdropPath ?? movieDetails?.posterPath, let imageUrl = URL(string: imageBaseUrl + imageUrlText), let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
               self.movieImageView.image = image
            }
         }
      }
      
   }

}
