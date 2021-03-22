//
//  GalleriesController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class GalleriesController: UICollectionViewController {
    //MARK: - Properties
    var galleries = [Gallery]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleries.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "GalleryCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GalleryCell else {
            fatalError("Unknown cell")
        }
        cell.frame.size = CGSize(width: 150, height: 150)
        cell.updateView(with: galleries[indexPath.row])
    
        return cell
    }
    
    func update(with data: [Gallery]) {
        galleries = data
        collectionView.reloadData()
    }
}
