//
//  HomeTableViewCell.swift
//  basic
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    /*
     
     let artist: String
     let index: Int
     let name: String
     let previewURL: URL
     
     */
    
    var artistLabel = BasicLabel()
    var albumLabel = BasicLabel()
    var nameLabel = BasicLabel()
    
    var previewImage: UIImageView = {
        let imageView = UIImageView()
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
        previewImage.anchor(top:self.topAnchor, left:self.leftAnchor, bottom:self.bottomAnchor, right:stackView.leftAnchor, topConstant:0, leftConstant:0, bottomConstant:0, rightConstant:0, widthConstant:100, heightConstant:100)
        stackView.anchor(top:self.topAnchor, left:previewImage.rightAnchor, bottom:self.bottomAnchor, right:self.rightAnchor, topConstant:4, leftConstant:4, bottomConstant:4, rightConstant:0, widthConstant:0, heightConstant:100)
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
