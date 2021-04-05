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
    
    var spinner: UIActivityIndicatorView!

    var fetchingMore = false
    var isLastPage = false
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createSpinner()

        guard let viewModel = viewModel else { return }
        title = viewModel.title
        
        viewModel.loadExhibits {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath) as? ExhibitionCellViewModelType  else {
            return UITableViewCell()
            
        }
        let cellIdentifier = cellViewModel.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExhibitTableViewCell else {
            fatalError("cell is not Exhibit view cell")
        }
        cell.viewModel = cellViewModel
        viewModel?.loadImage(forIndexPath: indexPath) {
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectCell(toIndexPath: indexPath)
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    //MARK: - UI initialization
    
    func createSpinner() {
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
    
//    func updateExhibits(fromGalleryData data: GalleryData) {
//        self.exhibits.removeAll()
//        for record in data.records {
//            guard let newExhibit = Exhibit(record: record) else {
//                continue
//            }
//            exhibits.append(newExhibit)
//        }
//        if self.exhibits.isEmpty {
//            self.isLastPage = true
//        }
//
//        self.tableView.reloadData()
//        self.spinner.stopAnimating()
//        self.fetchingMore = false
//    }
    
    // MARK: - Scrolling
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeigh = scrollView.contentSize.height
//        
//        if offsetY > contentHeigh - scrollView.frame.height {
//            if !fetchingMore  && !isLastPage {
//                updateData()
//            }
//        }
//    }
    
//    func updateData() {
//        fetchingMore = true
//        spinner.startAnimating()
//        currentPage += 1
////        loadExhibits(fromGallery: galleryNumber)
//    }
    
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
    
//    override func didMove(toParent parent: UIViewController?) {
//        super.didMove(toParent: parent)
//        self.clearData()
//    }
}

