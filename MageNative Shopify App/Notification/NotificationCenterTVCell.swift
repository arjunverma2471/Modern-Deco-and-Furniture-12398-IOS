//
//  NotificationCenterTVCell.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 03/02/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationCenterTVCell: UITableViewCell {
    
    @IBOutlet weak var imgStack: UIStackView!
    @IBOutlet weak var subHeading: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var arrowImg: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    var updateInterface:(()-> Void)?
    var imageUrl : String?
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.backgroundColor = .randomAlpha
        imgView.image = UIImage(named: "AppIcon")
        arrowImg.addTarget(self, action: #selector(renderImage(_:)), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(data:NotificationSendModel?) {
        guard var dat = data?.notification_data else {
            print("inside 1st guard")
            return}
       dat =  dat.replacingOccurrences(of: "\r\n", with: "\\r\\n")
        guard let dict = dat.convertToDictionary() else {
            print("inside 2nd guard")
            return}
        heading.text = dict["title"] as? String
        subHeading.text = dict["message"] as? String
        subHeading.numberOfLines = 2
        heading.font = mageFont.mediumFont(size: 12.0)
        subHeading.font = mageFont.regularFont(size: 12.0)
        imageUrl = dict["image"] as? String
        if imageUrl != "" {
            arrowImg.isHidden = false
        }
        else {
            arrowImg.isHidden = true
        }
        if data?.isExpanded == true {
            subHeading.numberOfLines = 0
            imgStack.subviews.forEach{$0.removeFromSuperview()}
            arrowImg.setImage(UIImage(named: "collapsearrow"), for: .normal)
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            guard let url = imageUrl?.getURL() else {return}
            imageView.setImageFrom(url)
            imgStack.addArrangedSubview(imageView)
            imageView.anchor(height: 150)
        }
        else {
            arrowImg.setImage(UIImage(named: "expandarrow"), for: .normal)
            imgStack.subviews.forEach{$0.removeFromSuperview()}
        }
    }
    
   @objc func renderImage(_ sender : UIButton) {
        updateInterface?()
    }
}

