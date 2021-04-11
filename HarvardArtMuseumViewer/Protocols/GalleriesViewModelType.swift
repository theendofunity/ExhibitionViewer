//
//  GalleriesViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 29.03.2021.
//

import Foundation

protocol GalleriesViewModelType: CollectionViewModelType {
    var title: String { get }
    func loadGalleries(completion: @escaping () -> Void)
    func exhibitsViewModel() -> ExhibitionViewModelType?
}
