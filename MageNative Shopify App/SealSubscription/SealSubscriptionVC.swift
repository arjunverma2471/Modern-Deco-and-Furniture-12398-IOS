//
//  SealSubscriptionVC.swift
//  MageNative Shopify App
//
//  Created by cedcoss on 14/06/23.
//  Copyright © 2023 MageNative. All rights reserved.
//

import UIKit

class SealSubscriptionVC: UIViewController {

    var sealSubVM: SealSubscriptionViewModel?
    
    lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(SealSubscriptionDetailTVCell.self, forCellReuseIdentifier: SealSubscriptionDetailTVCell.className)
    table.delegate = self
    table.dataSource = self
    return table
}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(light: .white, dark: .black)
        sealSubVM = SealSubscriptionViewModel()
        sealSubVM?.getSealSubscriptionsList()
    }
}

extension SealSubscriptionVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SealSubscriptionDetailTVCell.className, for: indexPath) as! SealSubscriptionDetailTVCell
        cell.backgroundColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
