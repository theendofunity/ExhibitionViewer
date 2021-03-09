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
    var networkManager = NetworkExhibitionManager()
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager.onCompletion = { [weak self] newExhibits in
                self?.exhibits = newExhibits
                self?.tableView.reloadData()
        }
        networkManager.requestData()
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
        
        var exhibit = exhibits[indexPath.row]
        cell.name.text = exhibit.title
        
        networkManager.downloadImage(fromUrl: exhibit.imageUrl) {image in
            exhibit.photo = image
            cell.photo.image = exhibit.photo
        }
        
        return cell
    }

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
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

    
    //MARK: Private methods
    

}
