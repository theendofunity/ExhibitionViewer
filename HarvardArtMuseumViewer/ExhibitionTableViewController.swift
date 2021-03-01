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
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSamples()
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
        cell.photo.image = exhibit.photo
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: Private methods
    
    func loadSamples() {
        guard let photo1 = UIImage(named: "testImage1") else {
            fatalError("Enable to open test image 1")
        }
        guard let photo2 = UIImage(named: "testImage2") else {
            fatalError("Enable to open test image 2")
        }
        let exhibit1 = Exhibit(title: "Exhibit1", photo: photo1)
        let exhibit2 = Exhibit(title: "Exhibit2", photo: photo2)
        
        exhibits.append(exhibit1)
        exhibits.append(exhibit2)
    }
    
}
