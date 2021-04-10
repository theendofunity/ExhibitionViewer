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
    
    func configurateCell() {
        backgroundColor = .blue
        galleryTitleLabel.numberOfLines = 0
    }
}
