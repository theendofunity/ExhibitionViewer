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
    var spinner: UIActivityIndicatorView!
    var currentPage = 1
    var fetchingMore = false
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        networkManager = NetworkExhibitionManager()
        
        networkManager.onCompletion = { [weak self] newExhibits in
            self?.exhibits = newExhibits
            self?.tableView.reloadData()
            
            self?.spinner.stopAnimating()
            self?.fetchingMore = false
        }
        networkManager.fetchData()
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
        cell.name.text = exhibit.title
        
        networkManager.downloadImage(fromUrl: exhibit.imageUrl, withIdentifier: exhibit.title) { image in
            self.exhibits[indexPath.row].photo = image
            cell.photo.image = image
        }
        
        return cell
    }

    // MARK: - Scrolling
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeigh = scrollView.contentSize.height
        
        if offsetY > contentHeigh - scrollView.frame.height {
            if !fetchingMore {
                updateData()
            }
        }
    }
    
    func updateData() {
        fetchingMore = true
        spinner.startAnimating()
        networkManager.fetchData()
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
