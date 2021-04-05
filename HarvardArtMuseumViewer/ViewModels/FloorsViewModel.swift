//
//  FloorsViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.03.2021.
//

import Foundation

class FloorsViewModel: FloorsViewModelType {
    var selectedCell: IndexPath?
    let floors = [1, 2, 3, 4, 5]
    
    func numberOfRows() -> Int {
        return floors.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionCellViewModelType? {
        let floorNumber = floors[indexPath.item]
        let cellModel = FloorCellViewModel(floorNumber: floorNumber)
        return cellModel
    }
    
    func selectCell(toIndexPath indexPath: IndexPath) {
        selectedCell = indexPath
    }

    func galleriesViewModel() -> GalleriesViewModelType? {
        guard let selectedCell = selectedCell else { return nil }
        let selectedFloor = floors[selectedCell.item]
        return GalleriesViewModel(floorNumber: selectedFloor)
    }
}
