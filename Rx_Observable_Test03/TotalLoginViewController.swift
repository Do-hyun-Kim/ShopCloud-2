//
//  TotalLoginViewController.swift
//  Rx_Observable_Test03
//
//  Created by Kim dohyun on 11/04/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit
import RxAlamofire
import Alamofire



class TotalLoginViewController: UIViewController {
    
    @IBOutlet weak var LoginTitle: UILabel!
    @IBOutlet weak var ShorkTitle: UILabel!
    @IBOutlet weak var OauthFacebook: UIButton!
    @IBOutlet weak var EmailLogin: UIButton!
    @IBOutlet weak var KakaoLogin: UIButton!
    @IBOutlet weak var GoogleLogin: UIButton!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailOauthTitle: UILabel!
    @IBOutlet weak var EmailOauth: UIButton!
    @IBOutlet weak var Company: UILabel!
    
    let currentImage = UIImageView()
    
    //클라이언트 측에서 버튼을 클릭시 서버 연동
    //http://192.168.1.101:8081/oauth2/authorization/kakao
    @IBAction func FaceLoginSession(_ sender: AnyObject) {
        
    }
    @IBAction func LoginPrepare(_ sender: AnyObject) {
        seguePrepare()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUI()
        SetUPLabelUI()
    }
    
    func SetUI(){
        LoginTitle.rx.base.text = "회원가입"
        LoginTitle.rx.base.font = UIFont.boldSystemFont(ofSize: 30)
        LoginTitle.rx.base.textAlignment = NSTextAlignment.center
        ShorkTitle.rx.base.text = "새로운 크라우드 펀딩 플랫폼 Shork지금 부터 만나보세요"
        ShorkTitle.rx.base.font = UIFont.systemFont(ofSize: 19)
        ShorkTitle.rx.base.textAlignment = NSTextAlignment.left
        ShorkTitle.rx.base.numberOfLines = 0
        ShorkTitle.rx.base.lineBreakMode = NSLineBreakMode.byWordWrapping
        ShorkTitle.rx.base.textColor = UIColor.gray
        //FacebookLoginButton
        OauthFacebook.rx.base.backgroundColor = UIColor(red: 0/255, green: 102/255, blue: 255/255, alpha: 1.0)
        OauthFacebook.rx.base.setAttributedTitle(NSAttributedString(string: "Facebook Login", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20),NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        OauthFacebook.rx.base.layer.cornerRadius = 3.0
//        OauthFacebook.rx.base.setTitleColor(UIColor.white, for: .normal)
        //EmailLoginButton
        EmailLogin.rx.base.setAttributedTitle(NSAttributedString(string: "이메일로 가입", attributes: [NSAttributedString.Key.font : UIFont.monospacedDigitSystemFont(ofSize: 17, weight: UIFont.Weight.light),NSAttributedString.Key.foregroundColor : UIColor.lightGray]), for: .normal)
        EmailLogin.leftImage(image: UIImage(named: "message01")!, renderMode: UIImage.RenderingMode.alwaysOriginal)
        EmailLogin.rx.base.contentEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 30)
        
        EmailLogin.rx.base.layer.borderWidth = 0.5
        EmailLogin.rx.base.layer.borderColor = UIColor.lightGray.cgColor
        //KakaoLoginButton
        KakaoLogin.leftImage(image: UIImage(named: "Take")! , renderMode: UIImage.RenderingMode.automatic)
        KakaoLogin.rx.base.setTitleColor(UIColor.black, for: .normal)
        KakaoLogin.rx.base.setAttributedTitle(NSAttributedString(string: "카카오", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]), for: .normal)
        KakaoLogin.rx.base.layer.borderWidth = 0.5
        KakaoLogin.rx.base.layer.borderColor = UIColor.gray.cgColor
        
        //GoogleLoginButton
        GoogleLogin.rx.base.layer.borderColor = UIColor.gray.cgColor
        GoogleLogin.rx.base.layer.borderWidth = 0.5
        GoogleLogin.leftImage(image: UIImage(named: "search")!, renderMode: UIImage.RenderingMode.automatic)
        GoogleLogin.rx.base.setAttributedTitle(NSAttributedString(string: "구글", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]), for: .normal)
        GoogleLogin.rx.base.setTitleColor(UIColor.black, for: .normal)
        
        //EmailOauthLoginView Button : 로그인 화면으로 전환 버튼
        
    }
    
    func SetUPLabelUI(){
        //UI Layout
        EmailLabel.rx.base.text = "또는"
        EmailLabel.rx.base.font = UIFont.systemFont(ofSize: 17)
        EmailLabel.rx.base.textAlignment = .center
        EmailLabel.rx.base.textColor = .gray
        
        //OauthLabel Layout
        EmailOauthTitle.rx.base.text = "이미 Shork 게정이 있나요?"
        EmailOauthTitle.rx.base.textColor = UIColor.gray
        EmailOauthTitle.rx.base.font = UIFont.systemFont(ofSize: 14)
        EmailOauthTitle.rx.base.textAlignment = .center
        
        //EmailOauth Layout
        EmailOauth.rx.base.setAttributedTitle(NSAttributedString(string: "로그인", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.cyan]), for: .normal)
        
        //CompanyLabel Layout
        Company.rx.base.text = "Copyrightⓒ2019 Teddypear All rights reserved."
        Company.rx.base.font = UIFont.systemFont(ofSize: 10)
        Company.rx.base.textColor = UIColor.lightGray
        Company.rx.base.textAlignment = .center
        
        
        
        
    }
    
    func seguePrepare(){
        let Mainview = self.storyboard?.instantiateViewController(withIdentifier: "AuthLogin") as? AuthEmailLoginViewController
        self.navigationController?.pushViewController(Mainview!, animated: true)
        
    }

}

extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.contentHorizontalAlignment = .left
        self.semanticContentAttribute = .forceLeftToRight
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    }
    
    func rightImage(image: UIImage, padding: CGFloat, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: padding)
    }
    
}
