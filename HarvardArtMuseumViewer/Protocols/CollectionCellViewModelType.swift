//
//  CollectionViewCellViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.03.2021.
//

import Foundation

protocol CollectionCellViewModelType: class {
    var cellTitle: String { get }
    var identifier: String { get}
}
