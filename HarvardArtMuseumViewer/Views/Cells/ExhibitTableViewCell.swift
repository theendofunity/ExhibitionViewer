//
//  ExhibitTableViewCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Admin on 01.03.2021.
//

import UIKit

class ExhibitTableViewCell: UITableViewCell {

    // MARK: Properties

    static let cellIdentifier: String = "ExhibitCell"

    let photo: UIImageView = UIImageView()
    let name: UILabel = UILabel()

    weak var viewModel: ExhibitionCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.name.text = viewModel.cellTitle
            self.photo.image = viewModel.photo
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        photo.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false

        name.numberOfLines = 0

        contentView.addSubview(photo)
        contentView.addSubview(name)

        NSLayoutConstraint.activate([
            photo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            name.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 20),
            name.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
