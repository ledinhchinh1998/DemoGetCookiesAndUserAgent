//
//  WebViewViewController.swift
//  DemoGetCookies
//
//  Created by Chinh le on 9/9/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import WebKit
import FBSDKLoginKit

class WebViewViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "http://facebook.com")
        let myRequest = URLRequest(url: myURL!)
                
        if #available(iOS 11, *) {
          webview.load(myRequest)
          webview.navigationDelegate = self
        }
    }
    
    override func loadView() {
        let preferences = WKPreferences()
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences = preferences
        webview = WKWebView(frame: .zero, configuration: webConfiguration)
        let userAgentValue = "Chrome/56.0.0.0 Mobile"
        webview.customUserAgent = userAgentValue
        webview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webview.uiDelegate = self
        view = webview
        webview.allowsBackForwardNavigationGestures = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 11, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.httpCookieStore.getAllCookies { (cookies) in
                print(cookies)
            }
        }
        
        webview.evaluateJavaScript("navigator.userAgent") { (result, error) in
            if let result = result as? String {
                print(result)
            }
        }
    }
}
