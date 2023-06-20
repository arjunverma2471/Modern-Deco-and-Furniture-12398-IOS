//
//  FeedDescriptionViewHandler.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 07/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation


class FeedDescriptionViewHandler: NSObject {
    
    let blackView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.regular))
    
     var backView: FeedDescriptionView = {
        let backView                                        = FeedDescriptionView()
        backView.translatesAutoresizingMaskIntoConstraints  = false
//        backView.backgroundColor                            = .white
        backView.layer.cornerRadius                         = 5
        return backView
    }()
    
    func showView(){
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss(_:)))
            blackView.addGestureRecognizer(tap)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            backView.alpha  = 0
            window.addSubview(backView)
            
            //  MARK: - Setting up backview
            //
            backView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            backView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            backView.heightAnchor.constraint(equalToConstant: 260).isActive           = true
            backView.widthAnchor.constraint(equalToConstant:window.frame.width - 50).isActive = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.blackView.alpha = 1
                self.backView.alpha  = 1
            })
        }
    }
    
    @objc func handleDismiss(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
            self.backView.alpha  = 0
            self.blackView.removeFromSuperview()
            self.backView.removeFromSuperview()
        }
    }
    
    override init() {
        super.init()
        showView()
    }
}





