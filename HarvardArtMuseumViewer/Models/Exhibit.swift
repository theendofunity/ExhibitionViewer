//
//  Exhibit.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 28.02.2021.
//

import UIKit

struct Exhibit {
    var title: String
    var imageUrl: String?
    var classification: String
    var authors = [String]()
    var authorsString: String {
        authors.joined(separator: " ")
    }
    var objectNumber: String
    var date: Int
    var label: String
    var photo: UIImage? 
    
    
    init?(record: GalleryRecord) {
        self.title = record.title
        self.imageUrl = record.imageUrl
        self.classification = record.classification
        self.objectNumber = record.objectNumber
        self.date = record.dateBegin
        self.label = record.labelText ?? "No description"
        self.photo = UIImage(named: "Placeholder image")
        
        for author in record.people {
            self.authors.append(author.name)
        }
    }
}
