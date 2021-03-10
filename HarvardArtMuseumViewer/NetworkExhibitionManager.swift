//
//  NetworkExhibitionManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class NetworkExhibitionManager {
    
    let downloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
    
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
    
    func downloadImage(fromUrl urlString: String, withIdentifier title: String, onComplition: @escaping ((UIImage?) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("Incorrect URL \(urlString)")
            return
        }
        if let image = downloader.imageCache?.image(withIdentifier: title) {
            onComplition(image)
            return
        }
        let urlRequest = URLRequest(url: url)
        downloader.download(urlRequest, completion:  { response in
            if case .success(let image) = response.result {
                self.downloader.imageCache?.add(image, for: urlRequest, withIdentifier: title)
                
                let size = CGSize(width: 100.0, height: 100.0)
                let scaledImage = image.af.imageScaled(to: size)
                DispatchQueue.main.async {
                    onComplition(scaledImage)
                }
            }
        })
        
    }
}
