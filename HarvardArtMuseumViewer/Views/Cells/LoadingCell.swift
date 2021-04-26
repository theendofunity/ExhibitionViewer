//
//  LoadingCell.swift
//  HarvardArtMuseumViewer
//
//  Created by Дмитрий Дудкин on 09.04.2021.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    static let cellIdentifier = "LoadingCell"
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        activityIndicator.startAnimating()
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        activityIndicator.style = .large
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
