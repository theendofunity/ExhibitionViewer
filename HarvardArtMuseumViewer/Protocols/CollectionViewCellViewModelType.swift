//
//  CollectionViewCellViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.03.2021.
//

import Foundation

protocol CollectionViewCellViewModelType: class {
    var cellTitle: String { get }
    var identifier: String { get}
    var requestId: Int { get }
}
