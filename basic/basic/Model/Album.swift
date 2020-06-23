//
//  Album.swift
//  basic
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import Foundation

class Album {
    let artist: String
    let index: Int
    let name: String
    let album: String
    let image: String
  
    init(name: String, artist: String, album:String, image: String, index: Int) {
        self.name = name
        self.artist = artist
        self.album = album
        self.image = image
        self.index = index
      }
}
