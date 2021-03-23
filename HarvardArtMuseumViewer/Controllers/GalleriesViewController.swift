//
//  TestCollectionViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 23.03.2021.
//

import UIKit

class GalleriesViewController: UICollectionViewController {

    //MARK: - Properties
    var galleries = [Gallery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleries.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "GalleryCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GalleryCell else {
            fatalError("Unknown cell")
        }
        cell.frame.size = CGSize(width: 150, height: 150)
        cell.backgroundColor = .blue
        cell.updateView(with: galleries[indexPath.item])
    
        return cell
    }
    
    func update(with data: [Gallery]) {
        galleries = data
        collectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("Prepare from gallery controller")
        if segue.identifier == "showExhibits" {
            guard let cell  = sender as? GalleryCell else {
                fatalError("Unexpected sender")
            }
            guard let viewController = segue.destination as? ExhibitionTableViewController else {
                fatalError("Unexpected destination")
            }
            print("PREPARE \(cell.galleryName)")
            viewController.galleryNumber = cell.galleryNumber
            viewController.loadExhibits(fromGallery: cell.galleryNumber)

        } else {
            fatalError("Unknown Identifier")
        }
    }
}
