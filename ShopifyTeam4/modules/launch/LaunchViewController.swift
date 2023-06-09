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
                if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil{
                    let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
                    let home = storyboard.instantiateViewController(identifier: "tab") as! UITabBarController
                    print("in the condition")
                    home.modalPresentationStyle = .fullScreen
                    home.modalTransitionStyle = .crossDissolve
                    self.present(home, animated: true)
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
                    viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(viewController, animated: false, completion: nil)
                }
            }
        }
    }
    
    
}










