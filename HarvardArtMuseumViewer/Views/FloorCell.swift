//
//  FloorCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class FloorCell: UICollectionViewCell {
    
    @IBOutlet weak var floorNumberLabel: UILabel!
    
    var viewModel: CollectionCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            floorNumberLabel.text = viewModel.cellTitle
        }
    }
}
