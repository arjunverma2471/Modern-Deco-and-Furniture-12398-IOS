//
//  Home+Argoid Data.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 18/05/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import Foundation
extension HomeViewController {
    
    func fetchHomeArgoidData() {
        getArgoidHomeTopDeals()
        getArgoidHomeRecommendedProducts()
        getHomeTrendingProducts()
        fetchHomeArrivalProducts()
    }
    
    func getArgoidHomeTopDeals() {
        self.fetchCustomerDetails { custId in
            self.argoidViewModel.fetchHomeTopProducts(user_id: custId ?? "", number_of_recommendations: 12) {[weak self] result in
                switch result {
                case .success:
                    print("success")
                    if let data = self?.argoidViewModel.homeTopDealsProducts {
                        if !data.isEmpty {
                            self?.homeTopDealsArgoid = self?.argoidViewModel.homeTopDealsProducts ?? []
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                    
                    
                case .failed(let err):
                    print("Argoid \(err)")
                }
            }
        }
        
    }
    
    
    func getArgoidHomeRecommendedProducts() {
        self.fetchCustomerDetails { custId in
            self.argoidViewModel.fetchHomeRecommendedProducts(user_id: custId ?? "", number_of_recommendations: 12) {[weak self] result in
                switch result {
                case .success:
                    print("success")
                    if let data = self?.argoidViewModel.homeRecommendedProducts {
                        if !data.isEmpty {
                            self?.homeRecommendationsArgoid = self?.argoidViewModel.homeRecommendedProducts ?? []
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                    
                    
                case .failed(let err):
                    print("Argoid \(err)")
                }
            }
        }
        
    }
    
    
    func fetchHomeArrivalProducts() {
        self.fetchCustomerDetails { custId in
            self.argoidViewModel.fetchHomeArrivals(user_id: custId ?? "", number_of_recommendations: 12) {[weak self] result in
                switch result {
                case .success:
                    print("success")
                    if let data = self?.argoidViewModel.homeArrivalProducts {
                        if !data.isEmpty {
                            self?.homeArrivalsArgoid = self?.argoidViewModel.homeArrivalProducts ?? []
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                    
                    
                case .failed(let err):
                    print("Argoid \(err)")
                }
            }
        }
    }
    
    
    
    func getHomeTrendingProducts() {
        self.fetchCustomerDetails { custId in
            self.argoidViewModel.fetchHomeTrending(user_id: custId ?? "", number_of_recommendations: 12) {[weak self] result in
                switch result {
                case .success:
                    print("success")
                    if let data = self?.argoidViewModel.homeTrendingProducts {
                        if !data.isEmpty {
                            self?.homeTrendingArgoid = self?.argoidViewModel.homeTrendingProducts ?? []
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                    
                    
                case .failed(let err):
                    print("Argoid \(err)")
                }
            }
        }
    }
    
    
    
    private func fetchCustomerDetails(completion: @escaping(String?) -> Void) {
        var customerID = ""
        if Client.shared.isAppLogin() {
            Client.shared.fetchCustomerDetails(completeion: {
                response,error in
                if let response = response, let id = response.customerId {
                    customerID = id.components(separatedBy: "/").last ?? ""
                    completion(customerID)
                }else {
                   // self.showErrorAlert(error: error?.localizedDescription)
                    completion(customerID)
                }
            })
        }
        else {
            completion(customerID)
        }
        
        
    }
}
