//
//  ExhibitsViewModelType.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import Foundation

protocol ExhibitionViewModelType: CollectionViewModelType {
    var title: String { get }
    var isLastPage: Bool { get }
    var selectedCell: IndexPath? { get }
    
    func loadExhibits(completion: @escaping () -> Void)
    func loadNextPage(completion: @escaping () -> Void)
    func loadImage(forIndexPath indexPath: IndexPath, completion: @escaping () -> Void)
    func detailViewModel() -> DetailedViewModelType?
}
