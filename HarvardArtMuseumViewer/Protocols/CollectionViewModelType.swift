//
//  FloorsViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.03.2021.
//

import Foundation

protocol CollectionViewModelType: class {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionCellViewModelType?
    func selectCell(toIndexPath indexPath: IndexPath)
}
