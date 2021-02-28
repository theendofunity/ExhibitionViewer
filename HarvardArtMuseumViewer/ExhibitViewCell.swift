//
//  TableViewCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.02.2021.
//

import UIKit

class ExhibitViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var objectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
