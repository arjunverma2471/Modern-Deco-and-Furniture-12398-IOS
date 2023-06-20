//
//  InstaHighlightsVC.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 13/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit

class InstaHighlightsVC: UIViewController {

    var storistaImage: [Story]?{
        didSet{
            storyCollection.reloadData()
        }
    }
    
    lazy var storyCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(light: .white,dark: UIColor.provideColor(type: .productVC).collectionViewBackgroundColor)
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        let nib = UINib(nibName: StoristaHighlightStoryCVCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: StoristaHighlightStoryCVCell.className)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(light: .white,dark: .black)
        setupView()
    }
        
    func setupView(){
        self.view.addSubview(storyCollection)
        storyCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        storyCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        storyCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        storyCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}


extension InstaHighlightsVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storistaImage?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:StoristaHighlightStoryCVCell.className, for: indexPath) as! StoristaHighlightStoryCVCell
        cell.storyImage.setImageFrom(URL(string: storistaImage?[indexPath.row].fileUrl ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
