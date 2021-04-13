//
//  FloorsViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import UIKit

class FloorsViewController: UICollectionViewController {
    //MARK: Properties
    
    var viewModel: FloorsViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FloorsViewModel()
        setupLayout()
        title = "Museums floors"
        
        collectionView.register(FloorCell.self, forCellWithReuseIdentifier: FloorCell.cellIdentifier)
    }

    // MARK: -  UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath) as? FloorCellViewModel else { return UICollectionViewCell() }
        let identifier = FloorCell.cellIdentifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FloorCell else {
            fatalError("Unknown cell")
        }
        cell.viewModel = cellViewModel
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectCell(toIndexPath: indexPath)
        performSegue(withIdentifier: "showGalleries", sender: nil)
    }
    
    //MARK: - UI Configuration
    
    func setupLayout() {
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
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "showGalleries" {
            guard let viewController = segue.destination as? GalleriesViewController else {
                fatalError("Unexpected destination")
            }
            let galleriesViewModel = viewModel?.galleriesViewModel()
            viewController.viewModel = galleriesViewModel
        } else {
            fatalError("Unknown Identifier")
        }
    }
}

