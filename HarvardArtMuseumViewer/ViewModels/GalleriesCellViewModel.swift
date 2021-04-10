//
//  GalleriesCellViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 29.03.2021.
//

import Foundation

class GalleriesCellViewModel: CollectionCellViewModelType {
    var gallery: Gallery
    
    var cellTitle: String {
        return gallery.name
    }
    
    var identifier: String = "GalleryCell"
    
    init(gallery: Gallery) {
        self.gallery = gallery
    }
}
