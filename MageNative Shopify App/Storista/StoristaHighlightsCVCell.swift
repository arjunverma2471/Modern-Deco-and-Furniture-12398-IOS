//
//  StoristaHighlightsCVCell.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 13/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit

class StoristaHighlightsCVCell: UICollectionViewCell {

    @IBOutlet weak var highlightsData: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        highlightsData.layer.cornerRadius = 100 * 0.5
    }
}
