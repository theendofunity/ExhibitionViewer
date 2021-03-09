//
//  Exhibit.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.02.2021.
//

import UIKit

struct Exhibit {
    let title: String
    let imageUrl: String
    var photo: UIImage? 

    
    init?(record: Record) {
        self.title = record.title
        self.imageUrl = record.imageUrl
    }
}
