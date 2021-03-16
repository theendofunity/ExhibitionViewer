//
//  ViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 24.02.2021.
//

import UIKit

class ExhibitViewController: UIViewController {

    //MARK: Properties
    
    var exhibit: Exhibit?
 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var peopleDataLabel: UILabel!
    @IBOutlet weak var objectNumberDataLabel: UILabel!
    @IBOutlet weak var workTypeDataLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       updateInterface()
    }

    func updateInterface() {
        guard let exhibit = exhibit else {
            return
        }
        name.text = exhibit.title
        photo.image = exhibit.photo
        workTypeDataLabel.text = exhibit.classification
        objectNumberDataLabel.text = exhibit.objectNumber
        dateLabel.text = String(exhibit.date)
        peopleDataLabel.text = exhibit.authorsString
    }

    @IBAction func showDescription(_ sender: Any) {
        
        let description = UIAlertController(title: "Description", message: exhibit?.label, preferredStyle: .actionSheet)
        description.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(description, animated: true, completion: nil)
    }
}

