//
//  DetailViewModel.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 01.04.2021.
//

import Foundation

class DetailedViewModel: DetailedViewModelType {
    var exhibit: Exhibit

    init(exhibit: Exhibit) {
        self.exhibit = exhibit
    }
}
