//
//  OauthPasswordViewController.swift
//  Rx_Observable_Test03
//
//  Created by Kim dohyun on 09/04/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit


class OauthPasswordViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var PassText: UITextField!
    @IBOutlet weak var OauthPass: UILabel!
    @IBOutlet weak var PassButton: UIButton!
    @IBOutlet weak var Passbottom: NSLayoutConstraint!
    @IBOutlet weak var PassAlertbottom: NSLayoutConstraint!
    @IBOutlet weak var PassAlert: UIView!
    @IBOutlet weak var Alerttitle: UILabel!
    @IBAction func NextPass(_ sender: AnyObject) {
        PasswordCheck(Password: PassText.text!)
    }
    @IBOutlet weak var PassProgress: UIProgressView!
    @IBOutlet weak var PassCount: UILabel!
    
    @IBAction func Checktext(_ sender: AnyObject) {
        if PassText.isEditing == true {
            PassAlert.isHidden = true
        }
    }
    var keyboardShow : Bool = false
    var originY : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        PassText.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(OauthPasswordViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OauthPasswordViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PassText.becomeFirstResponder()
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let userinfo = notification.userInfo as? Dictionary<String,AnyObject> {
            let frame = userinfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height as? CGFloat {
                self.Passbottom.constant = CGFloat(keyBoardHeight) + 10
                self.PassAlertbottom.constant = CGFloat(keyBoardHeight) + 10
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        self.Passbottom.constant = 60.0
    }
    
    
    
    
    func SetUpUI(){
        PassText.rx.base.borderStyle = .none
        PassText.rx.base.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        PassText.rx.base.font = UIFont.boldSystemFont(ofSize: 30)
        OauthPass.rx.base.font = UIFont.systemFont(ofSize: 14)
        OauthPass.rx.base.text = "비밀번호"
        PassButton.rx.base.backgroundColor = UIColor(red: 174/255.0, green: 224/255.0, blue: 221/255.0, alpha: 0.5)
        PassButton.rx.base.setAttributedTitle(NSAttributedString(string: "다음", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        // NextButton.rx.base.setTitleColor(UIColor.white, for: .disabled)
        PassButton.rx.base.layer.cornerRadius = 4.0
        PassAlert.rx.base.backgroundColor = UIColor(red: 230/255, green: 174/255, blue: 207/255, alpha: 1.0)
        Alerttitle.rx.base.textColor = UIColor.white
        PassAlert.isHidden = true
        Alerttitle.rx.base.font = UIFont.systemFont(ofSize: 14)
        PassProgress.rx.base.backgroundColor = UIColor(red: 174/255.0, green: 224/255.0, blue: 221/255.0, alpha: 1.0)
        PassProgress.rx.base.transform = PassProgress.transform.scaledBy(x: 1, y: 2.1)
        PassProgress.rx.base.progress = 0.7
        PassCount.rx.base.text = "2/3"
        
    }
    
    
    @objc func PasswordCheck(Password : String){
        if Password.isEmpty == true {
            Alerttitle.rx.base.text = "비밀번호를 입력해 주세요"
            PassAlert.rx.base.isHidden = false
        }else if Password.count < 7{
            Alerttitle.rx.base.text = "비밀번호가 너무 짧아요"
            PassAlert.rx.base.isHidden = false
        }else{
            let NameView = self.storyboard?.instantiateViewController(withIdentifier: "NameView")
            self.navigationController?.pushViewController(NameView!, animated: true)
            
        }
    }
    
}
