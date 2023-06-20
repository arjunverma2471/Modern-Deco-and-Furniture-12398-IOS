//
//  StoristaAPIHandler.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 06/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation

class StoristaAPIHandler{
        
    var storistaAPIHandler: StoristaAPIHandler?
    var storistaFeedWidget: StoristaFeedWidget?
    

    func getLayout()->String{
        return storistaFeedWidget?.style?.layout ?? ""
    }
    
    init() {
    }
    
    func getWidgetInfo(_ completion: @escaping (StoristaFeedWidget?)->()){
        // Feeds = puSkelnjFVjoylR
        // Reels = bBxax3EDrnhRLzk
        // Highlights = yx4bkm3hmNwPols
        let api = StoristaCredentials.getWidgetInformationURl(widgetID: "yx4bkm3hmNwPols")
        SharedNetworking.shared.sendRequestUpdated(api: api) { [weak self] (result) in
            switch result{
            case .success(let data):
              do{
                let json                     = try JSON(data: data)
                print(json)
                let decoder                  = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                self?.storistaFeedWidget     = try decoder.decode(StoristaFeedWidget.self, from: data)
                  completion(self?.storistaFeedWidget)
              }catch let error {
                  print("Function: \(#function), line: \(#line), Filepath: \(#filePath)",error)
                  completion(nil)
              }
            case .failure(let error):
                print("Function: \(#function), line: \(#line), Filepath: \(#filePath)",error)
                completion(nil)
            }
          }
        }
    }
