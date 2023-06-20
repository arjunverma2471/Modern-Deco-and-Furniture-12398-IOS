//
//  VideoPlayerVC.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 07/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class VideoPlayerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initView(){
        
    }
    
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // Present the player view controller
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(playerViewController, animated: true) {
                player.play()
            }
        }
    }
}
