//
//  LaunchViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 04/06/2023.
//
//

import UIKit

class LaunchViewController: UIViewController {


    @IBOutlet weak var launchLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLayoutSubviews() {
            self.showAnimation()

        
    }
    

    
    
    func showAnimation() {
        UIView.animate(withDuration: 2,animations: {
            self.imageView.frame = CGRect(x:   self.imageView.frame.minX-120, y:   self.imageView.frame.minY-120, width:   self.imageView.frame.width + 240, height:   self.imageView.frame.height + 240)
            
        }) { completion in
            if completion {
                self.labelAnimation()
                
            }
        }
    }
    func labelAnimation(){
        UIView.animate(withDuration: 1.5,animations: {  self.launchLabel.alpha=1}){
            completion in
            if completion {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
                viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(viewController, animated: false, completion: nil)
            }
        }
    }
    
    
}










