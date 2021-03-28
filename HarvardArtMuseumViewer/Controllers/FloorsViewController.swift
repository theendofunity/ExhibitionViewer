//
//  FloorsViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class FloorsViewController: UICollectionViewController {

    //MARK: - Properties
    
    let networkManager = NetworkExhibitionManager()
    
    let floors = [1, 2, 3, 4, 5]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateLayout()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return floors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "FloorCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FloorCell else {
            fatalError("Unknown cell")
        }
        cell.floorNumber = indexPath.row + 1
    
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
    }
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "showGalleries" {
            guard let cell  = sender as? FloorCell else {
                fatalError("Unexpected sender")
            }
            guard let viewController = segue.destination as? GalleriesViewController else {
                fatalError("Unexpected destination")
            }

            loadGalleries(forFloor: cell.floorNumber) { galleries in
                viewController.update(with: galleries)
            }

        } else {
            fatalError("Unknown Identifier")
        }
    }

    func loadGalleries(forFloor floor: Int, withCompletion completion: @escaping ([Gallery]) -> Void) {
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
            completion(galleries)
        }
    }
}

