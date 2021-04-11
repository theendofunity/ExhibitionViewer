//
//  FloorCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class FloorCell: UICollectionViewCell {
    
    @IBOutlet weak var floorNumberLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var viewModel: FloorCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            floorNumberLabel.text = viewModel.cellTitle
            backgroundImage.image = UIImage(named: "Floor\(viewModel.floorNumber)")
        }
    }
    
    override func awakeFromNib() {
        setupImageView()
    }
    
    func setupImageView() {
        backgroundImage.alpha = 0.3
        backgroundImage.contentMode = .scaleToFill
    }
}
