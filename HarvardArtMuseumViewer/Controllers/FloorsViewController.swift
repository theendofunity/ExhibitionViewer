//
//  FloorsViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class FloorsViewController: UICollectionViewController {

    //MARK: - Properties
    
    let networkManager = NetworkExhibitionManager()
    
    let floors = [1, 2, 3, 4, 5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showGalleries" {
            guard let cell  = sender as? FloorCell else {
                fatalError("Unexpected sender")
            }
            guard let viewController = segue.destination as? GalleriesController else {
                fatalError("Unexpected destination")
            }
            
            loadGalleries(forFloor: cell.floorNumber) { galleries in
                print(galleries)
                viewController.update(with: galleries)
            }
            
        } else {
            fatalError("Unknown Identifier")
        }
    }

    func loadGalleries(forFloor floor: Int, withCompletion completion: @escaping ([Gallery]) -> Void) {
        let request = FloorPageRequest(floorNumber: floor)
        
        networkManager.load(request: request){[weak self] (floorData: FloorData?) in

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
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
