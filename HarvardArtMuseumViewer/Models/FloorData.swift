//
//  FloorData.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 22.03.2021.
//

import Foundation

struct FloorData: Decodable {
    let records: [FloorRecord]
}

struct FloorRecord: Decodable {
    let galleryId: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case galleryId = "galleryid"
        case name
    }
}
