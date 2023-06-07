//
//  ViewController.swift
//  ShopifyTeam4
//
//  Created by Sara Eltlt on 03/06/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var adsCollection: UICollectionView!
   
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var brandsCollection: UICollectionView!
    
    @IBOutlet weak var container: UIView!
    var adsArray:[UIImage]=[UIImage(named: "ads1")!,UIImage(named: "ads2")!,UIImage(named: "ads3")!,UIImage(named: "ads4")!,UIImage(named: "ads5")!]
    var timer:Timer?
    var currentCellIndex=0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adsCollection.register(UINib(nibName: "AdvertisementsViewCell", bundle: nil), forCellWithReuseIdentifier: K.AdvertisementCellIdentifier)
        self.brandsCollection.register(UINib(nibName: "BrandViewCell", bundle: nil), forCellWithReuseIdentifier: K.brandCell)
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
        self.pageController.numberOfPages = adsArray.count
        self.container.layer.cornerRadius = self.view.bounds.width * 0.15
        self.container.layer.masksToBounds = true
        if let tabBarController = self.tabBarController {
            if let tabItems = tabBarController.tabBar.items {
                if tabItems.count >= 3 {
                    let secondTabBarItem = tabItems[2]
                    secondTabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
                    secondTabBarItem.title = "Profile"
                    
   
                }
            }
        }
    }


}













extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @objc func moveToNextIndex(){
        if currentCellIndex < adsArray.count - 1 {
            currentCellIndex += 1
        }else {
            currentCellIndex = 0
        }
        self.adsCollection.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        self.pageController.currentPage = currentCellIndex
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == adsCollection {
            return 1
        }else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollection {
            return adsArray.count
        }else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.AdvertisementCellIdentifier, for: indexPath)
            as! AdvertisementsViewCell
            cell.configureCell(image: adsArray[indexPath.row])
       
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.brandCell, for: indexPath)
            as! BrandViewCell
           cell.configureCell(title: "H&M", imageUrl: "test")
            cell.addToFavorite.isHidden = true
            return cell
        }
        
        
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == adsCollection {
            return CGSize(width: (collectionView.bounds.width*1.0), height: (collectionView.bounds.height*1.0))
        }else {
            return CGSize(width: (collectionView.bounds.width*0.5), height: (collectionView.bounds.height*1.0))
        }
  
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == adsCollection {
           return 20
        }else {
          return  20
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == adsCollection {
           return 0
        }else {
          return  0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        if collectionView == adsCollection {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
            if collectionView == adsCollection {
                print(indexPath.row)
            }else {
                let brandProducts = self.storyboard?.instantiateViewController(identifier: "brandProducts")
                as! BrandProductsViewController
                self.navigationController?.pushViewController(brandProducts, animated: true)
            }
    }
    
}

