//
//  FloorCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class FloorCell: UICollectionViewCell {
    static let cellIdentifier = "FloorCell"
    
    let floorNumberLabel: UILabel = UILabel()
    let backgroundImage: UIImageView = UIImageView()
    
    var viewModel: FloorCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            floorNumberLabel.text = viewModel.cellTitle
            backgroundImage.image = UIImage(named: "Floor\(viewModel.floorNumber)")
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
        floorNumberLabel.textAlignment = .center
        floorNumberLabel.font = UIFont.boldSystemFont(ofSize: 20)
    
        floorNumberLabel.numberOfLines = 0
        
        backgroundImage.alpha = 0.7
        backgroundImage.contentMode = .scaleToFill
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        floorNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(backgroundImage)
        contentView.addSubview(floorNumberLabel)
        
        NSLayoutConstraint.activate([
            floorNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            floorNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            floorNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            floorNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
