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
    var nameLabel = BasicLabel()
    let previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(artistLabel)
        addSubview(nameLabel)
        addSubview(previewImage)
        
        
        
    }

    //MARK: UPDATE
    var album: Album! {
        didSet {
            self.updateUI()
            self.setNeedsLayout()
        }
    }

    private func updateUI(){

    }
    
}
