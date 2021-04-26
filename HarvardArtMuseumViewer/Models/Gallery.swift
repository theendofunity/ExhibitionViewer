//
//  Gallery.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 22.03.2021.
//

import Foundation

struct Gallery {
    let name: String
    let galleryId: Int
    let theme: String?

    init?(with data: FloorRecord) {
        name = data.name
        galleryId = data.galleryId
        theme = data.theme

        if theme == nil {
            return nil
        }
    }
}
