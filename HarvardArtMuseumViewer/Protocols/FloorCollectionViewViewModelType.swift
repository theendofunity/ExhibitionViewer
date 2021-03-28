//
//  FloorCollectionViewViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.03.2021.
//

import Foundation

protocol FloorCollectionViewViewModelType: CollectionViewModelType {
    func floorCellViewModel(forIndexPath indexPath: IndexPath) -> FloorCellViewModelType?
}
