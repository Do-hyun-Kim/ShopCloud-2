//
//  OauthNameViewController.swift
//  Rx_Observable_Test03
//
//  Created by Kim dohyun on 10/04/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit



class OauthNameViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var NameText: UILabel!
    @IBOutlet weak var OauthName: UITextField!
    @IBOutlet weak var NameNext: UIButton!
    @IBOutlet weak var Namebottom: NSLayoutConstraint!
    @IBOutlet weak var NameAlert: UIView!
    @IBOutlet weak var Nametitle: UILabel!
    @IBOutlet weak var Alertbottom: NSLayoutConstraint!
    @IBOutlet weak var ProgressCount: UILabel!
    @IBOutlet weak var LastBar: UIProgressView!
    var keyboardShow : Bool = false
    var originY : CGFloat?
    @IBAction func NameChage(_ sender: AnyObject) {
        if OauthName.isEditing == true {
            NameAlert.isHidden = true
        }
        
    }
    @IBAction func CompleteBtn(_ sender: AnyObject) {
        NameCheck(Name: OauthName.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameSetUpUI()
        OauthName.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(OauthNameViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OauthNameViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        OauthName.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let userinfo = notification.userInfo as? Dictionary<String,AnyObject> {
            let frame = userinfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height as? CGFloat {
                self.Namebottom.constant = CGFloat(keyBoardHeight) + 10
                self.Alertbottom.constant = CGFloat(keyBoardHeight) + 10
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        self.Namebottom.constant = 60.0
    }
    
    
    func NameSetUpUI(){
        OauthName.rx.base.borderStyle = .none
        OauthName.rx.base.attributedPlaceholder = NSAttributedString(string: "성명을 입력하세요", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        OauthName.rx.base.font = UIFont.boldSystemFont(ofSize: 30)
        NameText.rx.base.font = UIFont.systemFont(ofSize: 14)
        NameText.rx.base.text = "성명"
        NameNext.rx.base.backgroundColor = UIColor(red: 174/255.0, green: 224/255.0, blue: 221/255.0, alpha: 0.5)
        NameNext.rx.base.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        NameNext.rx.base.layer.cornerRadius = 4.0
        NameAlert.rx.base.backgroundColor = UIColor(red: 280/255, green: 174/255, blue: 207/255, alpha: 1.0)
        Nametitle.rx.base.textColor = UIColor.white
        Nametitle.rx.base.font = UIFont.systemFont(ofSize: 14)
        LastBar.rx.base.backgroundColor = UIColor(red: 174/255.0, green: 224/255.0, blue: 221/255.0, alpha: 1.0)
        LastBar.rx.base.transform = LastBar.transform.scaledBy(x: 1, y: 2.1)
        LastBar.rx.base.progress = 1.0
        ProgressCount.rx.base.text = "3/3"
        NameAlert.isHidden = true
    }
    
    @objc func NameCheck(Name : String) {
        //성명 이름 짧아도 2글자 이상은 입력 하게
        if Name.isEmpty == true {
            Nametitle.rx.base.text = "성명을 입력해 주새요"
            NameAlert.rx.base.isHidden = false
        }else if Name.count <= 2 {
            Nametitle.rx.base.text = "올바른 성명을 입력해 주세요"
            NameAlert.rx.base.isHidden = false
        }else{
            let MainView = self.storyboard?.instantiateViewController(withIdentifier: "MainTabbar") as? UIMainTabbarViewController
            let Navi = UINavigationController(rootViewController: MainView!)
            self.present(Navi, animated: true, completion: nil)
        }
    }
}
