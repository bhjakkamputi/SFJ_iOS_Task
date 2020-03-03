//
//  MovieTableViewCell.swift
//  SFJ_iOS_Task
//
//  Created by Banu Harshavardhan on 03/03/20.
//  Copyright © 2020 BanuHarshavardhan. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

   @IBOutlet weak var movieImageView: UIImageView!
   @IBOutlet weak var movieTitleLabel: UILabel!
   @IBOutlet weak var moviewRatingLabel: UILabel!

   override func awakeFromNib() {
      super.awakeFromNib()
   }

   override func prepareForReuse() {
      super.prepareForReuse()
      self.movieImageView.image = nil
   }

   func populateWith(_ result: Result?) {
      self.movieTitleLabel.text = result?.title
      self.moviewRatingLabel.text = result?.voteAverage.description

      DispatchQueue.global(qos: .userInitiated).async {
         let imageBaseUrl = "http://image.tmdb.org/t/p/w185"
         if let imageUrlText = result?.posterPath, let imageUrl = URL(string: imageBaseUrl + imageUrlText), let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
               self.movieImageView.image = image
            }
         }
      }

   }

}
