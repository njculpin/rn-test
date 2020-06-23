//
//  DetailViewController.swift
//  basic
//
//  Created by Nick Culpin on 6/23/20.
//  Copyright © 2020 basic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // the detail is nearly identical to the table view cell itself
    // todo: redesign the visual look and feel
    // todo: retrieve the audio file and develop a player
    
    var album: Album! {
        didSet {
            self.updateUI()
        }
    }
    
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
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.equalSpacing
        stack.spacing = 0
        stack.alignment = UIStackView.Alignment.leading
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = album?.name
        
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(previewImage)
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(albumLabel)
        stackView.addArrangedSubview(nameLabel)
        previewImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 4).isActive = true
        previewImage.rightAnchor.constraint(equalTo: stackView.leftAnchor, constant: 4).isActive = true
        previewImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        previewImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        previewImage.anchorCenterYToSuperview()
        stackView.leftAnchor.constraint(equalTo: previewImage.rightAnchor, constant: -4).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 4).isActive = true
        stackView.anchorCenterYToSuperview()
    }

    private func updateUI(){
        artistLabel.text = album.artist
        albumLabel.text = album.album
        nameLabel.text = album.name
        previewImage.loadImageUsingCacheWithUrlString(album.image)
    }
    
}
