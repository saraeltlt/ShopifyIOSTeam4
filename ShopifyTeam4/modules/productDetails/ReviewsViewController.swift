//
//  ReviewsViewController.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 12/06/2023.
//

import UIKit

class ReviewsViewController: UIViewController {
    @IBOutlet weak var backButtonOutlet: UIButton!{
        didSet{
            backButtonOutlet.layer.cornerRadius = backButtonOutlet.bounds.width * 0.5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func bacckButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
