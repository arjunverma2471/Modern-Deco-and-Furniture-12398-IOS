//
//  SealSubscriptionVM.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 16/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation


class SealSubscriptionViewModel {
    

    func getSealSubscriptionsList() {
        //      guard let url = (AppSetUp.baseUrl + endPoint + Client.merchantID + "&handle=sidebar-menu-1").getURL() else {return}
        guard let url = ("https://app.sealsubscriptions.com/shopify/merchant/api/subscriptions?query=cedbill09@gmail.com").getURL() else {return}
        print("urlfvgbdfx: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("seal_token_y3l6h285jtryvoyr5kc5rkgk61c890vtgz7skgrp", forHTTPHeaderField: "X-Seal-Token")
        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        
        AF.request(request).responseData(completionHandler: { response in

            DispatchQueue.main.async {
                switch response.result {
                case .success :
                    print("success")
                    if let data = response.data {
                        do {
                            let json = try JSON(data: data)
                            print("4464644\(json)")
                            if json["success"].boolValue {
//                                let decoder = JSONDecoder()
//                                do {
//                                    self.items = try decoder.decode(SubscriptionModel.self, from: data)
//                                }
//                                catch let err {
//                                    print(err)
//                                    print(err.localizedDescription)
//                                }
//                                print("MenuModel== \(self.items)")
//                                let subs = self.items?.payload.subscriptions ?? []
//
//                                if subs.isEmpty {
//                                    DispatchQueue.main.async {
//                                        self.view.makeToast("No Subscription available".localized, duration: 1.0, position: .center)
//                                    }
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                        self.navigationController?.popViewController(animated: true)
//                                    }
//                                } else {
//                                    self.tableView.reloadData()
//                                }
                            }else{
                                print("Success is false")
                            }
                        }
                        catch let err {
                            print(err.localizedDescription)
                        }
                    }
                case .failure(let err) :
                    print("error",err.localizedDescription)}
            }
        })
    }
}
