//
//  BrandProductsViewController.swift
//  ShopifyTeam4
//
//  Created by Eslam gamal on 06/06/2023.
//

import UIKit

class BrandProductsViewController: UIViewController {
    var isFilterHidden = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container.layer.cornerRadius = self.view.bounds.width * 0.03
        self.container.layer.masksToBounds = true
        
    }
    
    @IBAction func priceFilterSlider(_ sender: UISlider) {
        priceFilter.text = "Price : \(Int(sender.value))"
        
    }
    @IBOutlet weak var priceFilter: UILabel!
    @IBAction func filter(_ sender: UIBarButtonItem) {
        if !isFilterHidden{
            self.filterContainerHeightConstrain.constant += -self.view.bounds.height*0.0551643
            self.view.layoutIfNeeded()
            self.filterContainer.isHidden = true
            print("minimize")
            isFilterHidden = true
        } else {
            self.filterContainerHeightConstrain.constant += self.view.bounds.height*0.0551643
            self.view.layoutIfNeeded()
            self.filterContainer.isHidden = false
            print("maximize")
            isFilterHidden = false
        }
        
    
    
    }
    
    @IBOutlet weak var container: UIView!
    
    
    @IBOutlet weak var filterContainer: UIView!
    
    
    
    @IBOutlet weak var filterContainerHeightConstrain: NSLayoutConstraint!
    
    
    
}
