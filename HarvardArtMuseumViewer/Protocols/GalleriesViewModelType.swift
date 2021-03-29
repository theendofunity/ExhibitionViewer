//
//  GalleriesViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 29.03.2021.
//

import Foundation

protocol GalleriesViewModelType: CollectionViewModelType {
    func update(with galleries: [Gallery])
    func selectCell(toIndexPath indexPath: IndexPath)
    func selectedGalleryNumber() -> Int?
}