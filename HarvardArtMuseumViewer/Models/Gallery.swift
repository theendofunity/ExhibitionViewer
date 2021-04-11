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
    let theme: String?
    
    init?(with data: FloorRecord) {
        name = data.name
        id = data.galleryId
        theme = data.theme
        
        if theme == nil {
            return nil
        }
    }
}
