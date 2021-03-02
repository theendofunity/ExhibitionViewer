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
    
    @IBOutlet weak var objectNumber: UITextField!
    @IBOutlet weak var workType: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var people: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exhibit = exhibit {
            name.text = exhibit.title
            photo.image = exhibit.photo
        }
    }


}

