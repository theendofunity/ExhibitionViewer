//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import Foundation

class NetworkExhibitionManager {
    func requestData() {
        let urlString = "https://api.harvardartmuseums.org/gallery?floor=2&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data
            {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            }
        }
        task.resume()
    }
}
