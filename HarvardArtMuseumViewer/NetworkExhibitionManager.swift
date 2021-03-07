//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import Foundation

class NetworkExhibitionManager {
    func requestData() {
        let urlString = "https://api.harvardartmuseums.org/object?gallery=2220&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let galleryData = try decoder.decode(GalleryData.self, from: data)
            print(galleryData.info.totalRecords)
        } catch let error as NSError {
            print("Error!")
            print(error.localizedDescription)
        }
    }
}
