//
//  GalleryCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    static let cellIdentifier = "GalleryCell"
    
    let galleryTitleLabel: UILabel = UILabel()
    let backgroundImage: UIImageView = UIImageView()
    
    weak var viewModel: CollectionCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            galleryTitleLabel.text = viewModel.cellTitle
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        galleryTitleLabel.textAlignment = .center
        galleryTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        galleryTitleLabel.numberOfLines = 0
        
        backgroundImage.image = UIImage(named: "GalleryPlaceholder")
        backgroundImage.alpha = 0.7
        backgroundImage.contentMode = .scaleToFill
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        galleryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(backgroundImage)
        contentView.addSubview(galleryTitleLabel)
        
        NSLayoutConstraint.activate([
            galleryTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            galleryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
