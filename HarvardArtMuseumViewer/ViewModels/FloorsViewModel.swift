//
//  FloorsViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.03.2021.
//

import Foundation

class FloorsViewModel: FloorCollectionViewViewModelType {
    
    let floors = [1, 2, 3, 4, 5]
    
    func numberOfRows() -> Int {
        return floors.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType? {
        let floorNumber = floors[indexPath.item]
        let cellModel = FloorCellViewModel(floorNumber: floorNumber)
        return cellModel
    }
    
    func floorCellViewModel(forIndexPath indexPath: IndexPath) -> FloorCellViewModelType? {
        guard let cellViewModel = cellViewModel(forIndexPath: indexPath) else { return nil }
        return cellViewModel as? FloorCellViewModelType
    }
    
}
