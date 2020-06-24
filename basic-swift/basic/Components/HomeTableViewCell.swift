//
//  HomeTableViewCell.swift
//  basic
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var artistLabel = BasicLabel()
    var albumLabel = BasicLabel()
    var nameLabel = BasicLabel()
    
    var previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.equalSpacing
        stack.spacing = 0
        stack.alignment = UIStackView.Alignment.leading
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: DRAW
    func setupViews() {
        addSubview(previewImage)
        addSubview(stackView)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(albumLabel)
        stackView.addArrangedSubview(nameLabel)
        previewImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        previewImage.rightAnchor.constraint(equalTo: stackView.leftAnchor, constant: 8).isActive = true
        previewImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        previewImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        previewImage.anchorCenterYToSuperview()
        
        stackView.leftAnchor.constraint(equalTo: previewImage.rightAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 4).isActive = true
        stackView.anchorCenterYToSuperview()
        // accessibility
        nameLabel.isAccessibilityElement = true
        nameLabel.accessibilityIdentifier = "list-cell-label"
    }

    //MARK: UPDATE
    var album: Album! {
        didSet {
            self.updateUI()
            self.setNeedsLayout()
        }
    }

    private func updateUI(){
        artistLabel.text = album.artist
        albumLabel.text = album.album
        nameLabel.text = album.name
        previewImage.loadImageUsingCacheWithUrlString(album.image)
    }
    
}
