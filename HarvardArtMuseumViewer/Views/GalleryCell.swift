//
//  GalleryCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    weak var viewModel: CollectionCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            galleryTitleLabel.text = viewModel.cellTitle
            configurateCell()
        }
    }

    @IBOutlet weak var galleryTitleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    func configurateCell() {
        galleryTitleLabel.numberOfLines = 0
        
        backgroundImage.image = UIImage(named: "GalleryPlaceholder")
        backgroundImage.alpha = 0.3
        backgroundImage.contentMode = .scaleToFill
    }
}
