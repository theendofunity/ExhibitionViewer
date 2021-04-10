//
//  ExhibitionCellViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import UIKit

class ExhibitionCellViewModel: ExhibitionCellViewModelType {
    var photo: UIImage?
    var identifier = "ExhibitCell"
    var exhibit: Exhibit
    var cellTitle: String {
        return exhibit.title
    }
    
    init(exhibit: Exhibit) {
        self.exhibit = exhibit
        self.photo = exhibit.photo
//            ?? UIImage(named: "Image placeholder")
    }
}
