//
//  Request.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 21.03.2021.
//

import Foundation

enum RequestType {
    case floor
    case gallery
    case galleryPage
}

protocol Request {
    var requestType: RequestType {get set}

    func pathWithParameters() -> String
}

struct GalleryPageRequest: Request {
    var requestType: RequestType = .galleryPage
    var galleryNumber: Int, pageNumber: Int

    func pathWithParameters() -> String {
        let path = "object?gallery=\(galleryNumber)&page=\(pageNumber)&apikey=\(apiKey)"
        return path
    }

    init(galleryNumber: Int, pageNumber: Int) {
        self.galleryNumber = galleryNumber
        self.pageNumber = pageNumber
    }
}

struct FloorPageRequest: Request {
    var requestType: RequestType = .floor
    var floorNumber: Int

    func pathWithParameters() -> String {
        let path = "gallery?floor=\(floorNumber)&apikey=\(apiKey)"
        return path
    }

    init(floorNumber: Int) {
        self.floorNumber = floorNumber
    }
}

struct GalleryRequest: Request {
    var requestType: RequestType = .gallery
    var galleryNumber: Int

    func pathWithParameters() -> String {
        let path = "object?gallery=\(galleryNumber)&apikey=\(apiKey)"
        return path
    }

    init(galleryNumber: Int) {
        self.galleryNumber = galleryNumber
    }
}
