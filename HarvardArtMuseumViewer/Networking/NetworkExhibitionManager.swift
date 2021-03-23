//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import Foundation



class NetworkExhibitionManager {
    let baseUrlString = "https://api.harvardartmuseums.org/"
    
    func load<T: Decodable>(request: Request, withCompletion completion: @escaping ((T?) -> Void)) {
        let urlString = "\(baseUrlString)\(request.pathWithParameters())"
        print(urlString)
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, request, error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(parsedData)
                }
            } catch {
                print("Error! \(error.localizedDescription)")
                return
            }
        }
        task.resume()
    }
}
