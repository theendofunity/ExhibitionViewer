//
//  GalleriesViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 29.03.2021.
//

import Foundation

class GalleriesViewModel: GalleriesViewModelType {
    
    var selectedCell: IndexPath?
    
    var galleries = [Gallery]()
    
    func gallery(forIndexPath indexPath: IndexPath) -> Gallery {
        return galleries[indexPath.item]
    }
    
    func numberOfRows() -> Int {
        return galleries.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType? {
        let gallery = galleries[indexPath.item]
        return GalleriesCellViewModel(gallery: gallery)
    }
    
    func update(with galleries: [Gallery]) { //  remove after networkManagerRefactoring
        self.galleries = galleries
    }
    
    func selectCell(toIndexPath indexPath: IndexPath) {
        selectedCell = indexPath
    }
    
    func selectedGalleryNumber() -> Int? {
        guard let selectedCell = selectedCell else { return nil }
        let gallery = galleries[selectedCell.item]
        return gallery.id
    }
}
