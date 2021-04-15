//
//  ExhibitionViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import Foundation

class ExhitionViewModel: ExhibitionViewModelType {
    var galleryNumber: Int
    var galleryTitle: String
    var isLastPage: Bool = false

    var currentPage: Int = 1
    var exhibits = [Exhibit]()
    var selectedCell: IndexPath?
    
    var title: String {
        return galleryTitle
    }
    
    let networkManager = NetworkManager()
    
    init(galleryNumber: Int, galleryTitle: String) {
        self.galleryNumber = galleryNumber
        self.galleryTitle = galleryTitle
    }
    
    func numberOfRows() -> Int {
        return exhibits.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionCellViewModelType? {
        let exhibit = exhibits[indexPath.row]
        
        return ExhibitionCellViewModel(exhibit: exhibit)
    }
    
    func selectCell(toIndexPath indexPath: IndexPath) {
        selectedCell = indexPath
    }
    
    func loadExhibits(completion: @escaping () -> Void) {
        networkManager.loadExhibits(forGallery: galleryNumber, pageNumber: currentPage) { [weak self] newExhibits in
            if newExhibits.isEmpty {
                self?.isLastPage = true
            } else {
                self?.exhibits += newExhibits
            }
            
            completion()
        }
    }
    
    func loadNextPage(completion: @escaping () -> Void) {
        if isLastPage {
            completion()
            return
        }
        currentPage += 1
        loadExhibits {
            completion()
        }
    }
    
    func loadImage(forIndexPath indexPath: IndexPath, completion: @escaping () -> Void) {
        var exhibit = exhibits[indexPath.row]
            networkManager.loadImage(fromUrl: exhibit.imageUrl, withIdentifier: exhibit.title) { [weak self] photo in
                exhibit.photo = photo
                self?.exhibits[indexPath.row] = exhibit
                completion()
            }
    }
    
    func detailViewModel() -> DetailedViewModelType? {
        guard let selectedCell = selectedCell else { return nil }
        let exhibit = exhibits[selectedCell.row]
        return DetailedViewModel(exhibit: exhibit)
    }
}
