//
//  ReviewsViewController.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 12/06/2023.
//

import UIKit

class ReviewsViewController: UIViewController {
    @IBOutlet weak var scrollableContentView: UIView!{
        didSet{
            scrollableContentView.layer.cornerRadius = scrollableContentView.bounds.width * 0.15
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
}
