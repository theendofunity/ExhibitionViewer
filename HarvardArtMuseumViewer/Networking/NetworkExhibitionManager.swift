//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import Foundation

class NetworkExhibitionManager {
    let baseUrlString = "https://api.harvardartmuseums.org/"
    
    func fetchData(withPageNumber page: Int, onCompletion: @escaping (([Exhibit]) -> Void)) {
        let urlString = baseUrlString + "object?gallery=2220&apikey=\(apiKey)&page=\(page)"
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let exhibits = self.parseJSON(withData: data) {
                    DispatchQueue.main.async {
                        onCompletion(exhibits)
                    }
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
