//
//  StoristaHighlightsTVCell.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 13/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit

class StoristaHighlightsTVCell: UITableViewCell {

    var parent: UIViewController?
    
    lazy var highLightsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.showsVerticalScrollIndicator   = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(light: .white,dark: UIColor.provideColor(type: .productVC).collectionViewBackgroundColor)
        collectionView.dataSource = self
        collectionView.delegate   = self

        let nib = UINib(nibName: StoristaHighlightsCVCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: StoristaHighlightsCVCell.className)
        
        return collectionView
    }()
    
    lazy var headingLabel:UILabel = {
        let l = UILabel()
        l.text = "Highlights"
        l.font = mageFont.mediumFont(size: 15)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var storistaHihhlights: [WidgetData]? {
        didSet{
            highLightsCollection.reloadData()
        }
    }
    
    func setupUI() {
        self.addSubview(headingLabel)
       backgroundColor = UIColor(light: .white,dark: UIColor.provideColor(type: .productVC).collectionViewBackgroundColor)
        headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        headingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        headingLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
       self.addSubview(highLightsCollection)
        highLightsCollection.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor).isActive = true
        highLightsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        highLightsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        highLightsCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
   }
}

extension StoristaHighlightsTVCell : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storistaHihhlights?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:StoristaHighlightsCVCell.className, for: indexPath) as! StoristaHighlightsCVCell
        let storistaImage = storistaHihhlights?.first?.previewFile
        cell.highlightsData.setImageFrom(URL(string: storistaImage ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = InstaHighlightsVC()
        let storistaImage = storistaHihhlights?[indexPath.row].stories
        vc.storistaImage = storistaImage
        vc.modalPresentationStyle = .popover
        self.parent?.present(vc, animated: true)
    }
}
