//
//  StoristaTVCell.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 06/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class StoristaTVCell: UITableViewCell {
    
    var parent: HomeViewController?
    let blackView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.regular))
    
     var backView: FeedDescriptionView = {
        let backView                                        = FeedDescriptionView()
        backView.translatesAutoresizingMaskIntoConstraints  = false
//        backView.backgroundColor                            = .white
        backView.layer.cornerRadius                         = 5
        return backView
    }()
    
    
    lazy var feedCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(light: .white,dark: UIColor.provideColor(type: .productVC).collectionViewBackgroundColor)
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        let nib = UINib(nibName: StoristaWidgetCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: StoristaWidgetCell.className)
        
        return collectionView
    }()
    
    lazy var headingLabel:UILabel = {
        let l = UILabel()
        l.text = "Feeds"
        l.font = mageFont.mediumFont(size: 15)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var storistaResult: StoristaFeedWidget?
    
    var feed: [Story]?{
        didSet{
            feedCollection.reloadData()
        }
    }
    
    func adjustLayout(_ scrollDirection: UICollectionView.ScrollDirection){
        if let flowLayout = feedCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = scrollDirection
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 0 , right: 15)
        }
    }
    
     func setupUI() {
         self.addSubview(headingLabel)
        backgroundColor = UIColor(light: .white,dark: UIColor.provideColor(type: .productVC).collectionViewBackgroundColor)
         headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
         headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
         headingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
         headingLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
         
        self.addSubview(feedCollection)
         feedCollection.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor).isActive = true
        feedCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        feedCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        feedCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
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
}

extension StoristaTVCell : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:StoristaWidgetCell.className, for: indexPath) as! StoristaWidgetCell
        cell.feedImage.backgroundColor = .yellow
        cell.storistaResult = self.storistaResult
        let feed  = feed?[indexPath.row]
        cell.feed = feed
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if storistaResult?.style?.layout == "slider"{
            if  UIDevice.current.model.lowercased() == "ipad".lowercased() {
                return collectionView.calculateHalfCellSizeOld(numberOfColumns: 5.1)
            }
              return collectionView.calculateHalfCellSizeOld(numberOfColumns: 2.3)
        }else if storistaResult?.style?.layout == "grid"{
            return collectionView.calculateVerticalCellSizeOld(numberOfColumns: 2,of: 210)
        }else{
            return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height - 15)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let feed = feed?[indexPath.row]
        if feed?.mediaType == "video" {
            guard let urlString = feed?.fileUrl else {return}
            guard let url = URL(string: urlString) else {return}
            productVideoClicked(url: url)
        }else{
            backView.setupData(feed?.title ?? "", feed?.fileUrl ?? "")
            showView()
        }
    }
    
    @objc func productVideoClicked(url:URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.modalPresentationStyle = .overCurrentContext
        self.parent?.present(playerViewController, animated: true) {
            player.play()
        }
    }
}
