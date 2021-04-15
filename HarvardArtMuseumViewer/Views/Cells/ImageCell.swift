//
//  ImageCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 15.04.2021.
//

import UIKit

class ImageCell: UITableViewCell {

    let photoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleToFill
        contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func changePhoto(newPhoto: UIImage?) {
        if newPhoto == nil {
            photoImageView.image = UIImage(named: "Image placeholder")
        } else {
            photoImageView.image = newPhoto
        }
    }
}
