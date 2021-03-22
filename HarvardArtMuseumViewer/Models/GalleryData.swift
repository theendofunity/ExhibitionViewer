//
//  GalleryData.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 07.03.2021.
//

import Foundation

struct GalleryData: Decodable {
    let info: Info
    let records: [GalleryRecord]
}

struct Info: Decodable {
    let page: Int
    let pages: Int
    let totalRecords: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case totalRecords = "totalrecords"
    }
}

struct GalleryRecord: Decodable {
    let classification: String
    let title: String
    let objectNumber: String
    let labelText: String?
    let imageUrl: String
    let dateBegin: Int
    let people: [People]
    
    enum CodingKeys: String, CodingKey {
        case classification
        case title
        case objectNumber = "objectnumber"
        case labelText = "labeltext"
        case imageUrl = "primaryimageurl"
        case dateBegin = "datebegin"
        case people
    }
}

struct People : Decodable {
    let name: String
}
