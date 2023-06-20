//
//  ArgoidRequests.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 18/05/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation
struct ArgoidSimilarProducts: Codable {
    let appSource: String?
    let userIDS: UserIDS?
    let entityIDS: EntityIDS?
    let numberOfRecommendations: Int?
    let recommendations: [Recommendation]?
    let status, recommendationID: String?

    enum CodingKeys: String, CodingKey {
        case appSource
        case userIDS = "userIds"
        case entityIDS = "entityIds"
        case numberOfRecommendations, recommendations, status
        case recommendationID = "recommendationId"
    }
}

// MARK: - EntityIDS
struct EntityIDS: Codable {
    let productID: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
    }
}

// MARK: - Recommendation
struct Recommendation: Codable {
    let id, entityType, defaultVariant, title: String?
    let status: String?
    let featuredImage: String?
    let images: [String]?
    let onlineStoreURL: String?
    let price: Price?

    enum CodingKeys: String, CodingKey {
        case id, entityType, defaultVariant, title, status, featuredImage, images
        case onlineStoreURL = "onlineStoreUrl"
        case price
    }
}

// MARK: - Price
struct Price: Codable {
    let actualPrice, currentPrice: String?
    let discount: Double?
}

// MARK: - UserIDS
struct UserIDS: Codable {
    let anonymousID: String?

    enum CodingKeys: String, CodingKey {
        case anonymousID = "anonymousId"
    }
}


final class ArgoidSimilarProductsRequest: Requestables {
    
    typealias Response =  ArgoidSimilarProducts
    
    var path: String {
        return url_path
    }
    
    var httpBody: Data? {
        var body: [String: Any] = [:]
        body.appendingQueryParameter(key: "appSource", value: "website")
        if Client.shared.isAppLogin() {
            body.appendingQueryParameter(key: "userIds", value: ["registeredUserId": user_id])
        }
        body.appendingQueryParameter(key: "numberOfRecommendations", value: "\(number_of_recommendations)")
        body.appendingQueryParameter(key: "includeOutOfStock", value: "\(include_out_of_stock)")
        body.appendingQueryParameter(key: "entityIds", value: ["productId": product_id])
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
        return jsonData
    }
    
    var headerField: [String: String] {
        var header: [String: Any] = [:]
        header.appendingQueryParameter(key: "Content-Type", value: "application/json")
        header.appendingQueryParameter(key: "Accept", value: "*/*")
        header.appendingQueryParameter(key: "Authorization", value: "Basic \(Client.argoidAuthToken)")
        return header as! [String : String]
    }
    
    var httpMethod: HTTPsMethods {
        return .post
    }
    
    private let url_path: String
    
    private let user_id: String
    
    private let number_of_recommendations: Int
    
    private let include_out_of_stock: Bool
    
    private let product_id: String
    
    init(user_id: String, number_of_recommendations: Int, include_out_of_stock: Bool, product_id: String, url_path: String) {
        self.user_id = user_id
        self.number_of_recommendations = number_of_recommendations
        self.include_out_of_stock = include_out_of_stock
        self.product_id = product_id
        self.url_path = url_path
    }
}


final class ArgoidCartSimilarProductsRequest: Requestables {
    
    typealias Response =  ArgoidSimilarProducts
    
    var path: String {
        return "CART-PAGE-RECOMMENDATION"
    }
    
    var httpBody: Data? {
        var body: [String: Any] = [:]
        body.appendingQueryParameter(key: "appSource", value: "website")
        body.appendingQueryParameter(key: "userIds", value: ["anonymousId": user_id])
        body.appendingQueryParameter(key: "numberOfRecommendations", value: "\(number_of_recommendations)")
        body.appendingQueryParameter(key: "entityIds", value: ["productIdsInCart": product_ids])
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
        return jsonData
    }
    
    var headerField: [String: String] {
        var header: [String: Any] = [:]
        header.appendingQueryParameter(key: "Content-Type", value: "application/json")
        header.appendingQueryParameter(key: "Accept", value: "*/*")
        header.appendingQueryParameter(key: "Authorization", value: "Basic \(Client.argoidAuthToken)")
        return header as! [String : String]
    }
    
    var httpMethod: HTTPsMethods {
        return .post
    }
    
    private let user_id: String
    
    private let number_of_recommendations: Int
    
    private let product_ids: [String]
    
    init(user_id: String, number_of_recommendations: Int, product_ids: [String]) {
        self.user_id = user_id
        self.number_of_recommendations = number_of_recommendations
        self.product_ids = product_ids
    }
}


final class ArgoidHomeProductsRequest: Requestables {
    
    typealias Response =  ArgoidSimilarProducts
    
    var path: String {
        return base_path
    }
    
    var httpBody: Data? {
        var body: [String: Any] = [:]
        body.appendingQueryParameter(key: "appSource", value: "website")
        body.appendingQueryParameter(key: "userIds", value: ["anonymousId": user_id])
        body.appendingQueryParameter(key: "numberOfRecommendations", value: "\(number_of_recommendations)")
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
        return jsonData
    }
    
    var headerField: [String: String] {
        var header: [String: Any] = [:]
        header.appendingQueryParameter(key: "Content-Type", value: "application/json")
        header.appendingQueryParameter(key: "Accept", value: "*/*")
        header.appendingQueryParameter(key: "Authorization", value: "Basic \(Client.argoidAuthToken)")
        return header as! [String : String]
    }
    
    var httpMethod: HTTPsMethods {
        return .post
    }
    
    private let user_id: String
    
    private let number_of_recommendations: Int
    
    private let base_path: String
    
    init(user_id: String, number_of_recommendations: Int, base_path: String) {
        self.user_id = user_id
        self.number_of_recommendations = number_of_recommendations
        self.base_path = base_path
    }
}


