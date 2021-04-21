//
//  ExhibitionTableViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 01.03.2021.
//

import UIKit

class ExhibitionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var viewModel: ExhibitionViewModelType?
    var fetchingMore = false
    
    
    //MARK - Initializer
    init(viewModel: ExhibitionViewModelType) {
        super.init(style: .plain)
        self.viewModel = viewModel
        loadViewIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        title = viewModel.title
        
        tableView.register(ExhibitTableViewCell.self, forCellReuseIdentifier: ExhibitTableViewCell.cellIdentifier)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.cellIdentifier)
        
        viewModel.loadExhibits { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel?.numberOfRows() ?? 0
        } else if section == 1 {
            guard let lastPage = viewModel?.isLastPage else { return 0 }
            if lastPage {
                return 0
            }
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0)
        {
            guard let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath) as? ExhibitionCellViewModelType  else {
                return UITableViewCell()
            }
            let cellIdentifier = ExhibitTableViewCell.cellIdentifier
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExhibitTableViewCell else {
                fatalError("cell is not Exhibit view cell")
            }
            cell.viewModel = cellViewModel
            if (cellViewModel.defaultImageUsed)
            {
                viewModel?.loadImage(forIndexPath: indexPath) { [weak self] in
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                    if indexPath == self?.viewModel?.selectedCell {
                        self?.updateDetailedView()
                    }
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.cellIdentifier, for: indexPath) as? LoadingCell else {
                fatalError("cell is not loading view cell")
            }
            cell.activityIndicator.startAnimating()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectCell(toIndexPath: indexPath)
        guard let detailedViewModel = viewModel?.detailViewModel() else { return }
        
        let detailedViewController = DetailedViewController(viewModel: detailedViewModel)
        detailedViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
    
    func updateDetailedView() {
        guard let currentViewController = navigationController?.visibleViewController as? DetailedViewController else { return }
        guard let detailedViewModel = viewModel?.detailViewModel() else { return }
        currentViewController.viewModel = detailedViewModel
    }
    
    // MARK: - Scrolling
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let maximumOffset = contentHeight - scrollView.frame.size.height

        if currentOffset > maximumOffset {
            loadMore()
        }
    }
    
    func loadMore() {
        if viewModel!.isLastPage {
            tableView.deleteSections(IndexSet(integer: 1), with: .automatic)
            return
        }
        if fetchingMore { return }
        
        fetchingMore = true
        
        self.viewModel?.loadNextPage { [weak self] in
            DispatchQueue.main.async {
                self?.fetchingMore = false
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showAlert() {
        let alertViewController = UIAlertController(title: "Error", message: "while fetching data", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertViewController.addAction(cancelAction)
        present(alertViewController, animated: true)
    }
}

