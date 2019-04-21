//
//  ViewController.swift
//  Rx_Observable_Test03
//
//  Created by 김도현 on 12/03/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import RxFacebook
import FBSDKLoginKit
import FBSDKCoreKit



struct CategoryModel {
    var categoryimage : UIImage
    var categorytitle : String
}

struct CellModel {

    var image : UIImage
    var category : String
    var title : String
    var money : Int
}







class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var collectionview2: UICollectionView!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    
    

    var dataModel : [CellModel] = [CellModel(image: UIImage(named: "Test01")!, category: "IT분야", title: "5G데이터 통신을 뛰어넘은 혁신적인 기술력 에어팟", money: 50000),CellModel(image: UIImage(named: "Test01")!, category: "IT분야", title: "전기 자동차와 수소 자동차를 버튼 하나로 모드를 바꿀수 있는 자동차", money: 100000),CellModel(image: UIImage(named: "Test01")!, category: "IT분야", title: "5G데이터 통신을 뛰어넘은 혁신적인 기술력 에어팟", money: 50000)]
    var categoryModel : [CategoryModel] = [CategoryModel(categoryimage: UIImage(named: "Test03")!, categorytitle: "IT분야"),CategoryModel(categoryimage: UIImage(named: "Test03")!, categorytitle: "테스트 카테고리"),CategoryModel(categoryimage: UIImage(named: "Test03")!, categorytitle: "테스트 카테고리")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview2.delegate = self
        collectionview2.dataSource = self
        collectionview2.reloadData()
        collectionview.reloadData()
        //Main
        let layout = self.collectionview.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 10, left: UIScreen.main.bounds.minX + 15, bottom: 0, right: UIScreen.main.bounds.minX + 15)
        layout?.minimumLineSpacing = 5
        layout?.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 50) / 2, height: (self.collectionview.bounds.maxY + 200) / 2)
        //categoty
        let categorylayout = self.collectionview2.collectionViewLayout as? UICollectionViewFlowLayout
        categorylayout?.scrollDirection = .vertical
        categorylayout?.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        categorylayout?.minimumInteritemSpacing = 0
        categorylayout?.minimumLineSpacing = 0
        categorylayout?.itemSize = CGSize(width: screenWidth/6, height: screenWidth/6)
        collectionview2.collectionViewLayout = categorylayout!
        
        let nib = UINib(nibName: "CustomCollectionCell", bundle: nil)
        collectionview.register(nib, forCellWithReuseIdentifier: "CustomCollectionCell")
        let categorynib = UINib(nibName: "CategoryColletionCell", bundle: nil)
        collectionview2.register(categorynib, forCellWithReuseIdentifier: "CategoryColletionCell")
        //server api
        
        //collectionview : UI설정
 
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if section == 0 {
            return categoryModel.count
        }else{
            return dataModel.count
        }
        
//        guard let cell = deq as? CustomCollectionViewCell,
//            dataModel.count > indexPath.row else { return CustomCollectionViewCell() }
        
    }
    
    


    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionview2 {
            let cell = collectionview2.dequeueReusableCell(withReuseIdentifier: "CategoryColletionCell", for: indexPath) as? CategoryColletionCell
            cell?.configure(with: categoryModel[indexPath.row])
            cell?.contentView.layer.borderColor = UIColor.gray.cgColor
            cell?.contentView.layer.borderWidth = 1.0
            cell?.layer.masksToBounds = false
            
            
            return cell!
        }else{
     
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as? CustomCollectionCell
            cell?.configure(with: dataModel[indexPath.row])
            cell?.contentView.layer.cornerRadius = 10.0
            cell?.contentView.layer.borderWidth = 1.0
            cell?.contentView.layer.borderColor = UIColor.clear.cgColor
            cell?.contentView.layer.masksToBounds = false
            cell?.layer.shadowColor = UIColor.gray.cgColor
            cell?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell?.layer.shadowRadius = 2.0
            cell?.layer.shadowOpacity = 1.0
            cell?.layer.masksToBounds = false
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
            graphRequest?.start(completionHandler: { (connection, result, error) in
                if error != nil {
                    print("Error",error!.localizedDescription)
                }else{
                    print(result!)
                    let field = result! as? [String:Any]
                    DispatchQueue.global().async {
                        if let imageURL = ((field!["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                            print(imageURL)
                            let url = URL(string: imageURL)
                            let data = NSData(contentsOf: url!)
                            let image = UIImage(data: data! as Data)
                            guard let saveimage = image else {
                                return print("nil image")
                            }
                            DispatchQueue.main.async {
                                cell?.Profileimg.image = saveimage
                            }
                        
                        }
                        
                    }
                    DispatchQueue.main.async {
                      cell?.name.text = field!["name"] as? String
                    }
                    
                    
                }
            })
            
            
            
//            cell?.layer.shadowPath = UIBezierPath(roundedRect: (cell?.bounds)!, cornerRadius: (cell?.contentView.layer.cornerRadius)!).cgPath
            
            return cell!
        }
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Mainheader", for: indexPath) as? MainHeaderView
            headerview?.MainTitle.text = "Main"
            return headerview!
        }
        fatalError()
    }
    
    
   
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//
//
//
//        let layer = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 10)
//        collectionViewLayout.collectionView?.layoutMargins = layer
//
//
//        return layer
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let size = CGSize(width: 180, height: 350)
//        collectionViewLayout.collectionView?.contentSize = size
//        return size
//    }
    
    


}

