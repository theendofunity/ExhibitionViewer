//
//  ExhibitionCellViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import UIKit

class ExhibitionCellViewModel: ExhibitionCellViewModelType {
    var defaultImageUsed: Bool

    var photo: UIImage?
    var identifier = "ExhibitCell"
    var exhibit: Exhibit
    var cellTitle: String {
        return exhibit.title
    }

    init(exhibit: Exhibit) {
        self.exhibit = exhibit
        if exhibit.photo == nil {
            defaultImageUsed = true
            self.photo = UIImage(named: "Image placeholder")
        } else {
            defaultImageUsed = false
            self.photo = exhibit.photo
        }
    }
}
