//
//  GuestViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 17/06/2023.
//

import UIKit
import Lottie

class GuestViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        animationView.loopMode = .loop
        animationView.play()
    }
    override func viewDidDisappear(_ animated: Bool) {
        animationView.stop()
    }
    @IBAction func goToLogin(_ sender: UIButton) {
        K.GUEST_MOOD=false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
        viewController.modalPresentationStyle = .fullScreen
          viewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
          self.present(viewController, animated: false, completion: nil)
    }
    

}
