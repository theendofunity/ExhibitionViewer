//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import UIKit

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
                    DispatchQueue.main.async {
                        self.onCompletion?(exhibits)
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
    
    func downloadImage(fromUrl urlString: String, onComplition: @escaping ((UIImage?) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return
        }
        var image: UIImage?

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                print("Error while fetching image")
                return
            }
            
            let downloadedImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                image = downloadedImage ?? UIImage(named: "Image placeholder")
                onComplition(image)
            }
        }
    }
}
