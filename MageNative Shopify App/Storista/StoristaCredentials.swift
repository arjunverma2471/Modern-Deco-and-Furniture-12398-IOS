//
//  StoristaCredentials.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 06/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation

struct StoristaCredentials{
    
  static let accessToken            = "c33171be6c7f3062b08e5c0b778e7b0d9f6f249b"
  static let baseURL                = "https://api.storista.io/"
  
   static func getWidgetInformationURl(widgetID: String)->String{
        return "\(StoristaCredentials.baseURL)/worker/v2/widgets/?widget_id=\(widgetID)&access_token=\(StoristaCredentials.accessToken)"
    }
}

