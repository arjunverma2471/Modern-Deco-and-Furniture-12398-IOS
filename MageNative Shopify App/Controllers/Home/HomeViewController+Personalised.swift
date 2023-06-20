//
//  HomeViewController+Personalised.swift
//  MageNative Shopify App
//
//  Created by Manohar Singh Rawat on 06/04/20.
//  Copyright © 2020 MageNative. All rights reserved.
//

import Foundation
extension HomeViewController
{
    
    func storistaCollectionHeight()->CGFloat{
        let collectionViewWidth: CGFloat = tableView.bounds.width // Width of the collection view
        let itemWidth: CGFloat = collectionViewWidth / 2 // Width of each item
        let itemHeight: CGFloat = 210 // Height of each item
        let spacing: CGFloat = 20 // Spacing between items
        let numberOfItems: Int = storistaResult?.data?.first?.stories?.count ?? 0 // Number of items in the collection view

        let numberOfColumns: Int = 2 // Number of columns in each row
        let numberOfRows = Int(ceil(Double(numberOfItems) / Double(numberOfColumns)))

        let collectionViewHeight = (itemHeight * CGFloat(numberOfRows)) + (spacing * CGFloat(numberOfRows - 1))
        print("My COLLECTION HEOIGHT==",collectionViewHeight)
        return collectionViewHeight + 35
    }
    
    
  func loadRecommendedProducts()
  {
    Client.shared.fetchRecommendedProducts(query: [ "queries": [["id": "query1","max_recommendations": 8,"recommendation_type": "bestsellers"],["id": "query2","max_recommendations": 8,"recommendation_type": "trending"]]]) { (json, error) in
      if let json = json{
        if let status = json["status"] as? String{
          if(status.lowercased() == "ok"){
            if let query1 = json["query1"] as? [String:Any]{
              if let products = query1["products"] as? [[String:Any]]{
                var ids = [GraphQL.ID]()
                for index in products{
                  let str="gid://shopify/Product/\(index["product_id"]!)"
                  //let str1 = (str).data(using: String.Encoding.utf8)
                  //let base64 = str1!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                  let graphId = GraphQL.ID(rawValue: str)
                  
                  ids.append(graphId)
                }
                Client.shared.fetchMultiProducts(ids: ids, completion: { [weak self] (response, error) in
                  if let response = response {
                    self?.bestSellingProducts = response
                    self?.tableView.reloadData()
                  }else {
                    
                  }
                })
              }
            }
            if let query1 = json["query2"] as? [String:Any]{
              if let products = query1["products"] as? [[String:Any]]{
                var ids = [GraphQL.ID]()
                for index in products{
                  let str="gid://shopify/Product/\(index["product_id"]!)"
//                  let str1 = (str).data(using: String.Encoding.utf8)
//                  let base64 = str1!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                  let graphId = GraphQL.ID(rawValue: str)
                  
                  ids.append(graphId)
                }
                Client.shared.fetchMultiProducts(ids: ids, completion: { [weak self] (response, error) in
                  if let response = response {
                    self?.trendingProducts = response
                    self?.tableView.reloadData()
                  }else {
                    
                  }
                })
              }
            }
          }
        }
      }
    }
  }
}
