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
    var viewModel: GalleriesViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateLayout()
        viewModel = GalleriesViewModel()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath) else { return UICollectionViewCell() }
        let identifier = cellViewModel.identifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GalleryCell else {
            fatalError("Unknown cell")
        }

        cell.viewModel = cellViewModel
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectCell(toIndexPath: indexPath)
        
        performSegue(withIdentifier: "showExhibits", sender: nil)
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
    
    func update(with data: [Gallery]) {
        viewModel?.update(with: data)
        collectionView.reloadData()
    }

    func fetchData(forFloor floor: Int) {
        title = "Floor \(floor)"
        
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
        if segue.identifier == "showExhibits" {
            guard let viewController = segue.destination as? ExhibitionTableViewController else {
                fatalError("Unexpected destination")
            }
            guard let galleryNumber = viewModel?.selectedGalleryNumber() else { return }
            viewController.loadExhibits(fromGallery: galleryNumber)

        } else {
            fatalError("Unknown Identifier")
        }
    }
}
