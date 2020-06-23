//
//  Labels.swift
//  basic
//
//  Created by Nick Culpin on 6/23/20.
//  Copyright © 2020 basic. All rights reserved.
//

import Foundation
import UIKit

class BasicLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
        self.textColor = .black
    }
    
}
