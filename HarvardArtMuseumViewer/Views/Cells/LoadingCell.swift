//
//  LoadingCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 09.04.2021.
//

import UIKit

class LoadingCell: UITableViewCell {


    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        activityIndicator.startAnimating()
    }
}
