//
//  ExhibitionViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import Foundation

class ExhitionViewModel: ExhibitionViewModelType {
    
    var galleryNumber: Int
    var currentPage: Int = 1
    var exhibits = [Exhibit]()
    var selectedCell: IndexPath?
    
    var title: String {
        return "Gallery \(galleryNumber)"
    }
    
    let networkManager = NetworkManager()
    
    init(galleryNumber: Int) {
        self.galleryNumber = galleryNumber
    }
    
    func numberOfRows() -> Int {
        return exhibits.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionCellViewModelType? {
        let exhibit = exhibits[indexPath.row]
//        DispatchQueue.main.async {
//            self.networkManager.loadImage(fromUrl: exhibit.imageUrl, withIdentifier: exhibit.title) { image in
//                self.exhibits[indexPath.row].photo = image
//            }
//        }
        
        return ExhibitionCellViewModel(exhibit: exhibit)
    }
    
    func selectCell(toIndexPath indexPath: IndexPath) {
        selectedCell = indexPath
    }
    
    func loadExhibits(completion: @escaping () -> Void) {
        networkManager.loadExhibits(forGallery: galleryNumber, pageNumber: currentPage) { newExhibits in
            self.exhibits = newExhibits
            completion()
        }
    }
    
    func loadImage(completion: @escaping () -> Void) {
        for var exhibit in exhibits {
            networkManager.loadImage(fromUrl: exhibit.imageUrl, withIdentifier: exhibit.title) { photo in
                exhibit.photo = photo
            }
        }
    }
    
    func detailViewModel() -> DetailedViewModelType? {
        guard let selectedCell = selectedCell else { return nil }
        let exhibit = exhibits[selectedCell.row]
        return DetailedViewModel(exhibit: exhibit)
    }
}
