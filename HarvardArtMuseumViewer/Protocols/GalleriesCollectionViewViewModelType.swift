//
//  GalleriesCollectionViewViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 29.03.2021.
//

import Foundation

protocol GalleriesCollectionViewViewModelType: CollectionViewModelType {
    func gallery(forIndexPath indexPath: IndexPath) -> Gallery
}
