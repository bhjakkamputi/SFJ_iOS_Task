//
//  ServiceManager.swift
//  SFJ_iOS_Task
//
//  Created by Banu Harshavardhan on 03/03/20.
//  Copyright © 2020 BanuHarshavardhan. All rights reserved.
//

import UIKit


class ServiceManager {

   static let shared = ServiceManager()

   private var apiKey: String {
      return "afcd94ff686904d5e80b3e543088a801"
   }

   private var baseUrl: String {
      return "https://api.themoviedb.org/3/movie/"
   }

   func getFrom<D: Decodable>(urlComponent: String, decodeType: D.Type, completionHandler: @escaping (D) -> ()) {

      let urlText = self.baseUrl + urlComponent + "?api_key=" + self.apiKey

      guard let url = URL(string: urlText) else {
         print("----------------- Invalid URL -----------------")
         return
      }

      var request = URLRequest(url: url)
      request.httpMethod = "GET"

      let session = URLSession(configuration: .default)
      let dataTask = session.dataTask(with: request) { (data, response, error) in
         guard let data = data else {
            print("----------------- No data available -----------------")
            return
         }
         do {
            let decoded = try JSONDecoder().decode(D.self, from: data)
            DispatchQueue.main.async {
               completionHandler(decoded)
            }
         } catch let decodingError {
            print("----------------- " + decodingError.localizedDescription + " -----------------")
         }
      }
      dataTask.resume()

   }

}
