//
//  ImageDownloadManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 16.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageDownloadManager {
    let downloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
    
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
