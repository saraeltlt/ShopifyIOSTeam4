//
//  OrderDetailsViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 11/06/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.09
        self.container.layer.masksToBounds = true
    }

}
