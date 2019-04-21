//
//  OauthLoginViewController.swift
//  Rx_Observable_Test03
//
//  Created by Kim dohyun on 08/04/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit


class OauthLoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var OAuthEmail: UILabel!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var EmailAlert: UIView!
    @IBOutlet weak var btnbottom: NSLayoutConstraint!
    @IBOutlet weak var AlertTitle: UILabel!
    @IBOutlet weak var Alertbottom: NSLayoutConstraint!
    @IBOutlet weak var AuthProgress: UIProgressView!
    
    @IBOutlet weak var PrgressCount: UILabel!
    var keyboardShow : Bool = false
    var originY : CGFloat?
    
    @IBAction func NotiText(_ sender: AnyObject) {
        if EmailText.isEditing == true {
            EmailAlert.isHidden = true
        }
    }
    
    @IBAction func PassNext(_ sender: AnyObject) {
        EmailCheck(Email: EmailText.text!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailText.delegate = self
        NaviSetUp()
        NotificationCenter.default.addObserver(self, selector: #selector(OauthLoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OauthLoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
        
    }
    override func viewDidAppear(_ animated: Bool) {
        EmailText.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let userinfo = notification.userInfo as? Dictionary<String,AnyObject> {
            let frame = userinfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height as? CGFloat {
            self.btnbottom.constant = CGFloat(keyBoardHeight) + 10
            self.Alertbottom.constant = CGFloat(keyBoardHeight) + 10
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        self.btnbottom.constant = 60.0
    }

        

    
    
    
    func NaviSetUp(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 174/255.0, green: 224/255.0, blue: 221/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title  = "Shock"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20),NSAttributedString.Key.foregroundColor : UIColor.white]
        BackButton.rx.base.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        BackButton.title = "뒤로가기"
        OAuthEmail.rx.base.font = UIFont.systemFont(ofSize: 14)
        OAuthEmail.rx.base.text = "이메일"
        EmailText.rx.base.borderStyle = .none
        EmailText.rx.base.attributedPlaceholder = NSAttributedString(string: "이메일을 입력하세요", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        EmailText.rx.base.font = UIFont.boldSystemFont(ofSize: 30)
        NextButton.rx.base.backgroundColor = UIColor(red: 174/255.0, green: 224/255.0, blue: 221/255.0, alpha: 0.5)
        NextButton.rx.base.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
       // NextButton.rx.base.setTitleColor(UIColor.white, for: .disabled)
        NextButton.rx.base.layer.cornerRadius = 4.0
        EmailAlert.rx.base.backgroundColor = UIColor(red: 230/255, green: 174/255, blue: 207/255, alpha: 1.0)
        AlertTitle.rx.base.textColor = UIColor.white
        EmailAlert.isHidden = true
        AlertTitle.rx.base.font = UIFont.systemFont(ofSize: 14)
        AuthProgress.rx.base.backgroundColor = UIColor(red: 174/255.0, green: 224/255.0, blue: 221/255.0, alpha: 1.0)
        AuthProgress.rx.base.transform = AuthProgress.transform.scaledBy(x: 1, y: 2.1)
        AuthProgress.rx.base.progress = 0.4
        PrgressCount.rx.base.text = "1/3"
    }
    
   
    
    @objc func goTosegue() {
        performSegue(withIdentifier: "MainNavi", sender: self)
    }
    
    @objc func EmailCheck(Email : String){
       
        if Email.contains("@") && Email.contains(".") {
            let Nextview = self.storyboard?.instantiateViewController(withIdentifier: "PassWordView")
            self.navigationController?.pushViewController(Nextview!, animated: true)
        }else if Email.isEmpty == true{
            AlertTitle.rx.base.text = "이메일 주소를 입력해 주세요"
            EmailAlert.rx.base.isHidden = false
        }else{
            AlertTitle.rx.base.text = "이메일을 잘못 입력하였습니다"
            EmailAlert.rx.base.isHidden = false
        }
    }
}

//맞으면 화면전환
//이메일을 입력하지 않으면 이메일 주소를 입력해 주세요 lert 띄우기
//그렇지 않으면 이메일 주소가 올바르지 않습니다 alert 띄우기

//지금 @. 것만 입력되도 true로 인정되면서 자동으로 넘어가진다
//그럼 이것을 버튼 클릭할떄만 넘어가지게끔 해야한다

