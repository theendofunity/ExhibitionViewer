//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import Foundation

enum RequestType {
    case floor(floorNumber: Int)
    case gallery(galleryNumber: Int)
    case galleryPage(galleryNumber: Int, pageNumber: Int)
}

class NetworkExhibitionManager {
    let baseUrlString = "https://api.harvardartmuseums.org/"
    
    func load<T>(type: RequestType, withCompletion completion: @escaping (([T]?) -> Void)) {
        let urlString = urlStringByType(type: type)
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return completion(nil)
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, request, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            let parsedData = self.parseJSON(withData: data)
            
            DispatchQueue.main.async {
                completion(parsedData as? [T])
            }
        }
        task.resume()
    }
    
    func urlStringByType(type: RequestType) -> String {
        var urlString: String = baseUrlString
        
        switch type {
        case .floor(let floorNumber):
            urlString += "gallery?floor=\(floorNumber)&apikey=\(apiKey)"
        case .gallery(let galleryNumber):
            urlString += "object?gallery=\(galleryNumber)&apikey=\(apiKey)"
        case .galleryPage(let galleryNumber, let pageNumber):
            urlString += "object?gallery=\(galleryNumber)&page=\(pageNumber)&apikey=\(apiKey)"
        }
        return urlString
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
