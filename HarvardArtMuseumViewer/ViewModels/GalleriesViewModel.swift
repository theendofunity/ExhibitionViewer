//
//  GalleriesViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 29.03.2021.
//

import Foundation

class GalleriesViewModel: GalleriesViewModelType {
    
    var floorNumber: Int?
    var selectedCell: IndexPath?
    var galleries = [Gallery]()
    
    let networkManager: NetworkManager = NetworkManager()
   
    init(floorNumber: Int) {
        self.floorNumber = floorNumber
    }

    func gallery(forIndexPath indexPath: IndexPath) -> Gallery {
        return galleries[indexPath.item]
    }
    
    func numberOfRows() -> Int {
        return galleries.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionCellViewModelType? {
        let gallery = galleries[indexPath.item]
        return GalleriesCellViewModel(gallery: gallery)
    }
    
    func loadGalleries(completion: @escaping () -> Void) {
        guard let floor = floorNumber else { return }
        networkManager.loadGalleries(forFloor: floor) { galleries in
            self.galleries = galleries
            completion()
        }
    }
    
    func selectCell(toIndexPath indexPath: IndexPath) {
        selectedCell = indexPath
    }
    
    func exhibitsViewModel() -> ExhibitionViewModelType? {
        guard let selectedCell = selectedCell else { return nil }
        let gallery = galleries[selectedCell.item]
        return ExhitionViewModel(galleryNumber: gallery.id)
    }

}
