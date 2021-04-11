//
//  TestCollectionViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 23.03.2021.
//

import UIKit

class GalleriesViewController: UICollectionViewController {

    //MARK: - Properties
    var viewModel: GalleriesViewModelType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = viewModel?.title
        setupLayout()
        
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else { return }
            viewModel.loadGalleries { [weak self] in
                self?.collectionView.reloadData()
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showExhibits" {
            guard let viewController = segue.destination as? ExhibitionTableViewController else {
                fatalError("Unexpected destination")
            }
            let exhibitsViewModel = viewModel?.exhibitsViewModel()
            viewController.viewModel = exhibitsViewModel
        } else {
            fatalError("Unknown Identifier")
        }
    }
}
