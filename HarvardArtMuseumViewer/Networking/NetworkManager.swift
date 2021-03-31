//
//  NetworkManager.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 31.03.2021.
//

import UIKit

class NetworkManager {
    let exhibitionNetworkManager = ExhibitionNetworkManager()
    let imageManager = ImageDownloadManager()
    
    func loadGalleries(forFloor floor: Int, completion: @escaping ([Gallery]) -> Void) {
        let request = FloorPageRequest(floorNumber: floor)
        
        exhibitionNetworkManager.load(request: request){(floorData: FloorData?) in
            guard let floorData = floorData else { return }
            
            var galleries = [Gallery]()
            for record in floorData.records {
                let gallery = Gallery(with: record)
                galleries.append(gallery)
            }
            completion(galleries)
        }
    }
    
    func loadExhibits(forGallery gallery: Int, pageNumber: Int, completion: @escaping ([Exhibit]) -> Void) {
        let request = GalleryPageRequest(galleryNumber: gallery, pageNumber: pageNumber)
        
        exhibitionNetworkManager.load(request: request) { (galleryData: GalleryData?) in
            guard let galleryData = galleryData else { return }
            
            var exhibits = [Exhibit]()
            for record in galleryData.records {
                guard let exhibit = Exhibit(record: record) else { continue }
                exhibits.append(exhibit)
            }
            completion(exhibits)
        }
    }
    
    func loadImage(fromUrl urlString: String, withIdentifier title: String, onCompletion: @escaping ((UIImage?) -> Void)) {
        imageManager.downloadImage(fromUrl: urlString, withIdentifier: title) { image in
            onCompletion(image)
        }
    }
}
