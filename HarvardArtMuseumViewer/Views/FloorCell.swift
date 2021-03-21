//
//  FloorCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class FloorCell: UICollectionViewCell {
    
    var floorNumber: Int = 0 {
        didSet {
            floorNumberLabel.text = "\(floorNumber)"
        }
    }
    
    @IBOutlet weak var floorNumberLabel: UILabel!
}
