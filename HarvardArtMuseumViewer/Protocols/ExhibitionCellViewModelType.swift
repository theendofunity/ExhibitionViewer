//
//  ExhibitionCellViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import UIKit

protocol ExhibitionCellViewModelType: CollectionCellViewModelType {
    var photo: UIImage? { get }
    var defaultImageUsed: Bool { get set }
}
