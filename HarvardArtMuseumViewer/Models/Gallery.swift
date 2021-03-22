//
//  Gallery.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 22.03.2021.
//

import Foundation

struct Gallery {
    let name: String
    let id: Int
    
    init(with data: FloorRecord) {
        name = data.name
        id = data.galleryId
    }
}
