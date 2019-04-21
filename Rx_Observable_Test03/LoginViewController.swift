//
//  LoginViewController.swift
//  Rx_Observable_Test03
//
//  Created by 김도현 on 03/04/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxFacebook
import FacebookCore
import FacebookLogin

class LoginViewController : UIViewController {
    
    @IBAction func EmailAuth(_ sender: AnyObject) {
    }
    @IBOutlet weak var EmailLogin: UIButton!
    @IBOutlet weak var AppName: UILabel!
    @IBOutlet weak var ShokBackImg: UIImageView!
    @IBOutlet weak var OauthLogin: UIButton!
    @IBAction func Loginbutton(_ sender: AnyObject) {
        signIn()
    }
    @IBAction func TotalLoginButton(_ sender: AnyObject) {
        let Loginvc = self.storyboard?.instantiateViewController(withIdentifier: "TotalNavi") as? UITotalLoginNaviViewController
        self.present(Loginvc!, animated: true, completion: nil)
        
    }
    
    let loginManiger : LoginManager = LoginManager()
    let disposeBag = DisposeBag()
    typealias EmailResult = (String?, String?)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginlayout()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    func signIn() {
        loginManiger.rx.logIn(with: [ReadPermission.publicProfile]).flatMap { [weak self] (LoginResults) -> Observable<EmailResult> in
            guard let strongself = self else { return .just((nil , "Somthing went wrong")) }
            switch LoginResults{
            case let .cancelled:
                return .just((nil, "User Cancelled Play"))
            case let .failed(error):
                return .just((nil, error.localizedDescription))
            case let .success(acceptedPermissions, declinedPermissions, accessToken):
                return strongself.fetchEmail()
            }
            
            }.subscribe(onNext:  { id,error in
                if case let name = id {
                    
                    //수정 보안 할 부분 : 버튼 클릭시 cancel 버튼 눌러도 바로 mainviewcontroller로 넘어감
                }else if case let err = error {
                    print(err)
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchEmail() -> Observable<EmailResult>{
        let graphRequest = GraphRequest(graphPath: "/me", parameters: ["fields": "name,id"])
        return graphRequest.rx.getResponse().map{ result in
            switch result {
            case let .success(response):
                
                
                let rootPage = self.storyboard?.instantiateViewController(withIdentifier: "MainTabbar") as? UIMainTabbarViewController
                let MainNavi = UINavigationController(rootViewController: rootPage!)
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window?.rootViewController = MainNavi
                guard let name = response.dictionaryValue?["name"] as? String else{
                    return (nil,"could't find id")
                }
                //                    guard let objectmap = response.dictionaryValue, let email = objectmap["id"] as? String else {
                
                //                        return (nil, "Could't find email")}
                
                print(name , "사용자정보입니다")
                return (name, nil)
            case let .failed(error):
                return (nil, error.localizedDescription)
            }
            
        }
    }
    
    func loginlayout(){
        OauthLogin.backgroundColor = UIColor.clear
        OauthLogin.setTitleColor(UIColor.white, for: .normal)
        OauthLogin.layer.borderColor = UIColor.white.cgColor
        OauthLogin.layer.borderWidth = 1.0
        OauthLogin.setTitle("다른 SNS 계정으로 시작하기", for: .normal)
        ShokBackImg.image = UIImage(named: "mainimg.jpg")
        EmailLogin.setTitle("이메일로 가입", for: .normal)
        EmailLogin.setTitleColor(UIColor.white, for: .normal)
        
        
    }
}
