//
//  ExhibitsViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import Foundation

protocol ExhibitionViewModelType: CollectionViewModelType {
    var title: String { get }
    
    func loadExhibits(completion: @escaping () -> Void)
    func loadImage(completion: @escaping () -> Void)
    func detailViewModel() -> DetailedViewModelType?
}
