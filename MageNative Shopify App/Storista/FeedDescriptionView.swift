//
//  FeedDescriptionView.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 07/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit

class FeedDescriptionView: UIView {
    
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var feedDesc: UITextView!
    
    var view: UIView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup()
    {
        view = loadViewFromNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        feedDesc.textColor = UIColor(light: .black,dark: .white)
        feedDesc.font = mageFont.regularFont(size: 11)
        feedDesc.contentMode = .top
    }
    
    func setupData(_ feedData: String,_ feedImage: String){
        let url = URL(string: feedImage)
        self.feedImage.setImageFrom(url)
        self.feedDesc.text = feedData
    }
    
    func loadViewFromNib() -> UIView
    {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "FeedDescriptionView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
