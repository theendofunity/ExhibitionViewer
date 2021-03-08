//
//  Exhibit.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.02.2021.
//

import UIKit

struct Exhibit {
    var title: String
    var photo: UIImage?
    
    init?(record: Record) {
        title = record.title
    }
}
