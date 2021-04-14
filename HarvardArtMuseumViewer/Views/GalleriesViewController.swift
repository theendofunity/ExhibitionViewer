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
    
    init(viewModel: GalleriesViewModelType) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.cellIdentifier)
        
        title = viewModel?.title
        
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.cellIdentifier, for: indexPath) as? GalleryCell else {
            fatalError("Unknown cell")
        }

        cell.viewModel = cellViewModel
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectCell(toIndexPath: indexPath)
        
        guard let exhibitsViewModel = viewModel?.exhibitsViewModel() else { return }
        let exhibitionViewController = ExhibitionTableViewController(viewModel: exhibitsViewModel)
        self.navigationController?.pushViewController(exhibitionViewController, animated: true)
    }
    
    func setupLayout() {
        collectionView.backgroundColor = .systemGray
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
}
