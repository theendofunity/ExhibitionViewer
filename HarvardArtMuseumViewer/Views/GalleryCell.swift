//
//  GalleryCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    var galleryNumber = 0
    var galleryName = ""
    
    @IBOutlet weak var galleryTitleLabel: UILabel!
    
    func updateView(with gallery: Gallery) {
        galleryName = gallery.name
        galleryNumber = gallery.id
        galleryTitleLabel.text = galleryName
    }
}
