//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import Foundation

class NetworkExhibitionManager {
    
    var onCompletion: (([Exhibit]) -> Void)?
    
    func requestData() {
        let urlString = "https://api.harvardartmuseums.org/object?gallery=2220&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let exhibits = self.parseJSON(withData: data) {
                    self.onCompletion?(exhibits)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> [Exhibit]? {
        let decoder = JSONDecoder()
        do {
            let galleryData = try decoder.decode(GalleryData.self, from: data)
            
            var exhibits = [Exhibit]()
            
            for record in galleryData.records {
                guard let exhibit = Exhibit(record: record) else {
                    return nil
                }
                exhibits.append(exhibit)
            }
            return exhibits
        } catch let error as NSError {
            print("Error!")
            print(error.localizedDescription)
        }
        return nil
    }
}
