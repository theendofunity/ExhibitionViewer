//
//  GalleriesCellViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 29.03.2021.
//

import Foundation

class GalleriesCellViewModel: CollectionViewCellViewModelType {
    var gallery: Gallery
    
    var cellTitle: String {
        return gallery.name
    }
    
    var identifier: String = "GalleryCell"
    
    var requestId: Int {
        return gallery.id
    }
    
    init(gallery: Gallery) {
        self.gallery = gallery
    }
}
