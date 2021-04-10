//
//  ViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 24.02.2021.
//

import UIKit

class DetailedViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var peopleDataLabel: UILabel!
    @IBOutlet weak var objectNumberDataLabel: UILabel!
    @IBOutlet weak var workTypeDataLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var showDescription: UIButton!
    
    weak var viewModel: DetailedViewModelType? {
        didSet {
            self.updateInterface()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateInterface() {
        guard let viewModel = viewModel else { return }
        
        loadViewIfNeeded()
        
        let exhibit = viewModel.exhibit
        name.text = exhibit.title
        photo.image = exhibit.photo
        workTypeDataLabel.text = exhibit.classification
        objectNumberDataLabel.text = exhibit.objectNumber
        dateLabel.text = String(exhibit.date)
        peopleDataLabel.text = exhibit.authorsString
        
        if exhibit.label.isEmpty {
            showDescription.isEnabled = false
        }
    }

    @IBAction func showDescription(_ sender: Any) {
        let description = UIAlertController(title: "Description", message: viewModel?.exhibit.label, preferredStyle: .actionSheet)
        description.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(description, animated: true, completion: nil)
    }
}

