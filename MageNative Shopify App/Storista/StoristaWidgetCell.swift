//
//  StoristaWidgetCell.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 06/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit

class StoristaWidgetCell: UICollectionViewCell {
    
    var storistaResult: StoristaFeedWidget?

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likesView: UIStackView!
    @IBOutlet weak var viewsView: UIStackView!
    @IBOutlet weak var viewsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.outerView.layer.masksToBounds = false
        self.feedImage.clipsToBounds = true
        self.outerView.cardViewWithDarkModeSupport()
        playButton.isHidden = true
        playButton.tintColor = UIColor.white
        feedImage.contentMode = .scaleAspectFill
        likesView.isHidden = true
        viewsView.isHidden = true
        
    }

    var feed: Story?{
        didSet{
            feedImage.layer.cornerRadius = CGFloat(storistaResult?.style?.radius ?? 0)
            outerView.layer.cornerRadius = CGFloat(storistaResult?.style?.radius ?? 0)
            if feed?.mediaType == "video"{
                feedImage.setImageFrom(URL(string: feed?.metadata?.thumbnailUrl ?? ""))
                playButton.setImage(UIImage(named: "videoicon"), for: .normal)
                playButton.isHidden = false
            }else{
                feedImage.setImageFrom(URL(string: feed?.fileUrl ?? ""))
                playButton.isHidden = true
            }
            viewsVisibilityHandling()
        }
    }
    
    
    func viewsVisibilityHandling(){
        if let likeVisibile = storistaResult?.style?.likesVisible,
           let viewsVisible = storistaResult?.style?.viewsVisible {
            if likeVisibile{
                likesView.isHidden  = false
                likeCount.text      = String(feed?.likes ?? 0)
            }
            if viewsVisible{
                viewsView.isHidden = false
                viewsCount.text    = String(feed?.views ?? 0)
            }
        }
    }
}
