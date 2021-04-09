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
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        title = viewModel.title
        
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
            guard let lastPage = viewModel?.isLastPage else { return 0}
            if lastPage {
                return 0
            }
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0)
        {
            guard let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath) as? ExhibitionCellViewModelType  else {
                return UITableViewCell()
            }
            let cellIdentifier = cellViewModel.identifier
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExhibitTableViewCell else {
                fatalError("cell is not Exhibit view cell")
            }
            cell.viewModel = cellViewModel
            if (cellViewModel.photo == nil)
            {
                viewModel?.loadImage(forIndexPath: indexPath) { [weak self] in
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else {
                fatalError("cell is not loading view cell")
            }
            cell.activityIndicator.startAnimating()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectCell(toIndexPath: indexPath)
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    // MARK: - Scrolling
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let maximumOffset = contentHeight - scrollView.frame.size.height * 4

        if currentOffset > maximumOffset {
            loadMore()
        }
    }
    
    func loadMore() {
        guard !fetchingMore else { return }
        
        fetchingMore = true
        
        DispatchQueue.global().async {
            sleep(2)
            
            DispatchQueue.main.async {
                self.viewModel?.loadNextPage {
                    self.fetchingMore = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let identifier = segue.identifier ?? ""
        
        if identifier == "showDetails" {
            guard let exhibitionViewController = segue.destination as? DetailedViewController else {
                fatalError("Unexpected destination") }
            
            guard let detailedViewModel = viewModel?.detailViewModel() else { return }
            print(detailedViewModel)
            exhibitionViewController.viewModel = detailedViewModel
        } else {
            fatalError("Unexpected segue identifier \(identifier)")
        }
     }
}

