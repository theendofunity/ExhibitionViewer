//
//  FloorCellViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.03.2021.
//

import Foundation

class FloorCellViewModel: CollectionViewCellViewModelType {
    var identifier: String = "FloorCell"

    var floorNumber: Int
    
    var cellTitle: String {
        return "Floor \(floorNumber)"
    }
    
    var requestId: Int {
        return floorNumber
    }
    
    init(floorNumber: Int) {
        self.floorNumber = floorNumber
    }
}
