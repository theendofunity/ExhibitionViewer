//
//  NetworkManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 31.03.2021.
//

import UIKit

class NetworkManager {
    let baseUrl: String = "https://api.harvardartmuseums.org/"
    let downloader: Downloader
    let imageManager = ImageDownloadManager()

    init() {
        downloader =  Downloader(baseUrl: self.baseUrl)
    }

    func loadGalleries(forFloor floor: Int, completion: @escaping ([Gallery]) -> Void) {
        let request = FloorPageRequest(floorNumber: floor)

        downloader.load(request: request) {(floorData: FloorData?, error: Error?) in
            if error != nil {
                self.showAlert()
                return
            }

            guard let floorData = floorData else { return }

            var galleries = [Gallery]()
            for record in floorData.records {
                guard let gallery = Gallery(with: record) else { continue }
                galleries.append(gallery)
            }
            completion(galleries)
        }
    }

    func loadExhibits(forGallery gallery: Int, pageNumber: Int, completion: @escaping ([Exhibit]?) -> Void) {
        let request = GalleryPageRequest(galleryNumber: gallery, pageNumber: pageNumber)

        downloader.load(request: request) { (galleryData: GalleryData?, error: Error?) in
            if error != nil {
                self.showAlert()
                return
            }
            guard let galleryData = galleryData else {
                completion(nil)
                return
            }
            var exhibits = [Exhibit]()
            for record in galleryData.records {
                guard let exhibit = Exhibit(record: record) else { continue }
                exhibits.append(exhibit)
            }
            completion(exhibits)
        }
    }

    func loadImage(fromUrl urlString: String,
                   withIdentifier title: String,
                   onCompletion: @escaping ((UIImage?) -> Void)) {
        imageManager.downloadImage(fromUrl: urlString, withIdentifier: title) { image in
            onCompletion(image)
        }
    }

    private func showAlert() {
        DispatchQueue.main.async {
            let rootController = UIApplication.shared.windows.first?.rootViewController
            let alertViewController = UIAlertController(title: "Error",
                                                        message: "while fetching data",
                                                        preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertViewController.addAction(cancelAction)
            rootController?.present(alertViewController, animated: true)
        }
    }
}
