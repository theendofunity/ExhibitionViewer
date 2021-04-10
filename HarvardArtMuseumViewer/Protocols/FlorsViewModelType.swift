//
//  FlorsViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import Foundation

protocol FloorsViewModelType: CollectionViewModelType {
    func galleriesViewModel() -> GalleriesViewModelType?
}
