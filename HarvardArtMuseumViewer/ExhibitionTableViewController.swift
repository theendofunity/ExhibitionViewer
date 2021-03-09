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
        
        let exhibit = exhibits[indexPath.row]
        cell.name.text = exhibit.title
        
        networkManager.downloadImage(fromUrl: exhibit.imageUrl) { image in
//            let smallerImage = image.
            self.exhibits[indexPath.row].photo = image
            cell.photo.image = image
        }
        
        return cell
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
            
            print("Prepare")
            let selectedExhibit = exhibits[indexPath.row]
            if selectedCell.photo != nil {
                print("Photo exist")
            }
            print(selectedExhibit)
            exhibitionViewController.exhibit = selectedExhibit
        } else {
            fatalError("Unexpected segue identifier \(identifier)")
        }
     }
}
