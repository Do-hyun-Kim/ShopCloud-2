//
//  AuthEmailLoginViewController.swift
//  Rx_Observable_Test03
//
//  Created by Kim dohyun on 17/04/2019.
//  Copyright © 2019 김도현. All rights reserved.
//

import UIKit


class AuthEmailLoginViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUI()
        webview.delegate = self
    }
    
    func SetUI(){
        webview.loadRequest(URLRequest(url: URL(string: "http://192.168.1.101:8081/oauth2/authorization/kakao")!))
    }
    
}
