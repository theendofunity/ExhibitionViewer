//
//  ExhibitTableViewCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 01.03.2021.
//

import UIKit

class ExhibitTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    weak var viewModel: ExhibitionCellViewModelType? {
        willSet(viewModel){
            guard let viewModel = viewModel else { return }
            self.name.text = viewModel.cellTitle
        }
    }
    
}
