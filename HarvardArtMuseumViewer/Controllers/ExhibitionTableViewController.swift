//
//  ExhibitionTableViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 01.03.2021.
//

import UIKit

class ExhibitionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var exhibits = [Exhibit]()
    var networkManager: NetworkExhibitionManager!
    var imageDownloader: ImageDownloadManager!
    var spinner: UIActivityIndicatorView!
    var currentPage = 1
    var fetchingMore = false
    var isLastPage = false
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSpinner()
        networkManager = NetworkExhibitionManager()
        fetchData()
        imageDownloader = ImageDownloadManager()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exhibits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ExhibitTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExhibitTableViewCell else {
            fatalError("cell is not Exhibit view cell")
        }
        
        let exhibit = exhibits[indexPath.row]
        cell.updateView(with: exhibit)
        
        imageDownloader.downloadImage(fromUrl: exhibit.imageUrl, withIdentifier: exhibit.title) { image in
            self.exhibits[indexPath.row].photo = image
            cell.updateView(with: self.exhibits[indexPath.row])
        }
        
        return cell
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
    
    func fetchData() {
        let requestType = GalleryPageRequest(galleryNumber: 2220, pageNumber: currentPage)
        networkManager.load(request: requestType) { [weak self] (galleryData: GalleryData?) in
            guard let self = self else {
                return
            }
            guard let galleryData = galleryData else {
                return
            }
            self.updateExhibits(fromGalleryData: galleryData)
        }
    }
    
    func updateExhibits(fromGalleryData data: GalleryData) {
        self.exhibits.removeAll()
        for record in data.records {
            guard let newExhibit = Exhibit(record: record) else {
                continue
            }
            exhibits.append(newExhibit)
        }
        if self.exhibits.isEmpty {
            self.isLastPage = true
        }
        
        self.tableView.reloadData()
        self.spinner.stopAnimating()
        self.fetchingMore = false
    }
    // MARK: - Scrolling
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeigh = scrollView.contentSize.height
        
        if offsetY > contentHeigh - scrollView.frame.height {
            if !fetchingMore  && !isLastPage {
                updateData()
            }
        }
    }
    
    func updateData() {
        fetchingMore = true
        spinner.startAnimating()
        currentPage += 1
        fetchData()
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let identifier = segue.identifier ?? ""
        
        if identifier == "Show details" {
            guard let exhibitionViewController = segue.destination as? ExhibitViewController else {
                fatalError("Unexpected destination") }
            
            guard let selectedCell = sender as? ExhibitTableViewCell else {
                fatalError("Unexpected sender") }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedExhibit = exhibits[indexPath.row]

            exhibitionViewController.exhibit = selectedExhibit
        } else {
            fatalError("Unexpected segue identifier \(identifier)")
        }
     }
}

