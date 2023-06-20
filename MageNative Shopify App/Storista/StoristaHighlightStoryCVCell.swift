//
//  StoristaHighlightStoryCVCell.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 14/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit

class StoristaHighlightStoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        storyImage.contentMode = .scaleAspectFill
        
        // Initialization code
    }
}
