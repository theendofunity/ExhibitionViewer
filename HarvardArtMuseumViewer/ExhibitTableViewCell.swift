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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
