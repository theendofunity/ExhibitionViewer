//
//  ViewController.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 24.02.2021.
//

import UIKit

class DetailedViewController: UITableViewController {

    //MARK: - Cells
    
    var cells = [UITableViewCell]()
    
    weak var viewModel: DetailedViewModelType? {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: - Initializer
    
    init(viewModel: DetailedViewModelType) {
        super.init(style: .plain)
        self.viewModel = viewModel
        loadViewIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Tableview
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section <= cells.count && indexPath.row == 0 {
            return cells[indexPath.section]
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headers = [nil, "Peoples", "Object number", "Work type", "Date", "Description"]
        
        if section >= headers.count {
            return nil
        }
        return headers[section]
    }
    
    override func loadView() {
        super.loadView()
        
        tableView.allowsSelection = false
        
        guard let viewModel = viewModel else { return }
        
        let exhibit = viewModel.exhibit
        title = exhibit.title
        
        let imageCell: UITableViewCell = UITableViewCell()
        var imageContentConfiguration = imageCell.defaultContentConfiguration()
        imageContentConfiguration.imageProperties.reservedLayoutSize = CGSize(width: 250, height: 250)
        let image = exhibit.photo
        imageContentConfiguration.image = image
        imageCell.contentConfiguration = imageContentConfiguration
        cells.append(imageCell)
  
        let peopleCell: UITableViewCell = UITableViewCell()
        var peopleContentConfiguration = peopleCell.defaultContentConfiguration()
        peopleContentConfiguration.text = exhibit.authorsString
        peopleCell.contentConfiguration = peopleContentConfiguration
        cells.append(peopleCell)
        
        let objectNumberCell: UITableViewCell = UITableViewCell()
        var objectNumberContentConfiguration = objectNumberCell.defaultContentConfiguration()
        objectNumberContentConfiguration.text = exhibit.objectNumber
        objectNumberCell.contentConfiguration = objectNumberContentConfiguration
        cells.append(objectNumberCell)
        
        let workTypeCell: UITableViewCell = UITableViewCell()
        var workTypeContentConfiguration = workTypeCell.defaultContentConfiguration()
        workTypeContentConfiguration.text = exhibit.classification
        workTypeCell.contentConfiguration = workTypeContentConfiguration
        cells.append(workTypeCell)
        
        let dateCell: UITableViewCell = UITableViewCell()
        var dateContentConfiguration = dateCell.defaultContentConfiguration()
        dateContentConfiguration.text = String(exhibit.date)
        dateCell.contentConfiguration = dateContentConfiguration
        cells.append(dateCell)
        
        let descriptionCell: UITableViewCell = UITableViewCell()
        var descriptionContentConfiguration = descriptionCell.defaultContentConfiguration()
        descriptionContentConfiguration.text = exhibit.label
        descriptionCell.contentConfiguration = descriptionContentConfiguration
        cells.append(descriptionCell)
    }
}

