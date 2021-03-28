//
//  TestCollectionViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 23.03.2021.
//

import UIKit

class GalleriesViewController: UICollectionViewController {

    //MARK: - Properties
    let networkManager = NetworkExhibitionManager()
    var galleries = [Gallery]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleries.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "GalleryCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GalleryCell else {
            fatalError("Unknown cell")
        }

        cell.backgroundColor = .blue
        cell.galleryTitleLabel.numberOfLines = 0
        cell.updateView(with: galleries[indexPath.item])
    
        return cell
    }
    
    func configurateLayout() {
        let itemsAtRow: CGFloat = 2
        let inset: CGFloat = 20

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumInteritemSpacing = inset
        layout.minimumLineSpacing = inset

        let paddingWidth = inset * (itemsAtRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthForItem = availableWidth / itemsAtRow
        layout.itemSize = CGSize(width: widthForItem, height: widthForItem)
        print(widthForItem)
    }
    
    func update(with data: [Gallery]) {
        galleries = data
        collectionView.reloadData()
    }

    func fetchData(forFloor floor: Int) {
        let request = FloorPageRequest(floorNumber: floor)
        
        networkManager.load(request: request){(floorData: FloorData?) in
            
            guard let floorData = floorData else {
                return
            }
            
            var galleries = [Gallery]()
            for record in floorData.records {
                let gallery = Gallery(with: record)
                galleries.append(gallery)
            }
            self.update(with: galleries)
        }
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
