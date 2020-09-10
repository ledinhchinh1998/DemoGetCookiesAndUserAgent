//
//  ViewController.swift
//  DemoGetCookies
//
//  Created by Chinh le on 9/9/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Foundation
import WebKit
import FBSDKLoginKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var messageLabel: UILabel!    
    @IBOutlet weak var loginButton: FacebookLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.loginCompletionHandler = { [weak self] (button, result) in
            switch result {
            case .success(let result):
                print("Access token: \(String(describing: result.token?.tokenString))")
                Profile.loadCurrentProfile { [weak self] (profile, error) in
                    self?.updateMessage(with: Profile.current?.name)
                }
            case .failure(let error):
                print("Error occurred: \(error.localizedDescription)")
            }
        }
        
        loginButton.logoutCompletionHandler = { [weak self] button in
//            let dataStore = WKWebsiteDataStore.default()
//            dataStore.httpCookieStore.getAllCookies { (cookies) in
//                print(cookies)
//            }
            self?.updateMessage(with: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("ViewDidAppear")
    }
    
    func updateMessage(with name: String?) {
        guard let name = name else {
            messageLabel.text = "Please log in with Facebook"
            return
        }
        
        messageLabel.text = "Hello, \(name)"
    }
    
    @IBAction func webViewAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension WKWebViewConfiguration {
    
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}






