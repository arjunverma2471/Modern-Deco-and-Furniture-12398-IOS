//
//  ArgoidViewModel.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 18/05/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation
class ArgoidViewModel {
    let product_similar_products_path = "PDP-SIMILAR-PRODUCTS"
    let product_recent_products_path = "RECENTLY-VIEWED"
    let products_style_path = "STYLE-IT-WITH"
    let home_top_products_path = "TOP-DEALS"
    let home_recommended_products_path = "RECOMMENDED-FOR-YOU"
    let home_trending = "TRENDING"
    let home_arrivals = "LATEST-ARRIVALS"
    var recommendedProducts = [ProductViewModel]()
    var recentlyViewProducts = [ProductViewModel]()
    var styledProducts = [ProductViewModel]()
    var cartSimilarProducts = [ProductViewModel]()
    var homeRecommendedProducts = [ProductViewModel]()
    var homeTopDealsProducts = [ProductViewModel]()
    var homeTrendingProducts = [ProductViewModel]()
    var homeArrivalProducts = [ProductViewModel]()
    func fetchSimilarProducts(user_id: String, number_of_recommendations: Int, include_out_of_stock: Bool, product_id: String, completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidSimilarProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, include_out_of_stock: include_out_of_stock, product_id: product_id, url_path: product_similar_products_path)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let recommended = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in recommended {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.recommendedProducts = response
                            completion(.success(true))
                        }
                    }
                   
                }
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
    
    func fetchRecentlyViewedProducts(user_id: String, number_of_recommendations: Int, include_out_of_stock: Bool, product_id: String, completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidSimilarProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, include_out_of_stock: include_out_of_stock, product_id: product_id, url_path: product_recent_products_path)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let recent = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in recent {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.recentlyViewProducts = response
                            completion(.success(true))
                        }
                    }
                }
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
    
    func fetchStyledProducts(user_id: String, number_of_recommendations: Int, include_out_of_stock: Bool, product_id: String, completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidSimilarProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, include_out_of_stock: include_out_of_stock, product_id: product_id, url_path: products_style_path)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let recent = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in recent {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.styledProducts = response
                            completion(.success(true))
                        }
                    }
                }
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
    
    
    func fetchCartSimilarProducts(user_id: String, number_of_recommendations: Int, product_ids: [String], completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidCartSimilarProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, product_ids: product_ids)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let similar = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in similar {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.cartSimilarProducts = response
                            completion(.success(true))
                        }
                    }
                }
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
    
    
    func fetchHomeTopProducts(user_id: String, number_of_recommendations: Int, completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidHomeProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, base_path: home_top_products_path)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let top = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in top {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.homeTopDealsProducts = response
                            completion(.success(true))
                        }
                    }
                }
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
    
    
    func fetchHomeTrending(user_id: String, number_of_recommendations: Int, completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidHomeProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, base_path: home_trending)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let top = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in top {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.homeTrendingProducts = response
                            completion(.success(true))
                        }
                    }
                }
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
    
    
    func fetchHomeArrivals(user_id: String, number_of_recommendations: Int, completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidHomeProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, base_path: home_arrivals)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let top = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in top {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.homeArrivalProducts = response
                            completion(.success(true))
                        }
                    }
                }
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
    
    func fetchHomeRecommendedProducts(user_id: String, number_of_recommendations: Int, completion: @escaping (RequestsResult<Bool, String>) -> ()) {
        let request = ArgoidHomeProductsRequest(user_id: user_id, number_of_recommendations: number_of_recommendations, base_path: home_recommended_products_path)
        IntegrationsNetworking.shared.send(request) {[weak self] response in
            switch response {
            case .success(let result):
                if let recommended = result.recommendations {
                    var ids = [GraphQL.ID]()
                    for items in recommended {
                        let graphId = GraphQL.ID(rawValue: items.id ?? "")
                        ids.append(graphId)
                    }
                    Client.shared.fetchMultiProducts(ids: ids) { response, error in
                        if let response = response {
                            self?.homeRecommendedProducts = response
                            completion(.success(true))
                        }
                    }
                }
                completion(.success(true))
            case .failed(let err):
                let err = (String (describing: err))
                completion(.failed(err))
            }
        }
    }
}

