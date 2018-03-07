//
//  WKWViewController.swift
//  Sample
//
//  Created by Watanabe Takehiro on 2018/03/05.
//  Copyright © 2018年 Watanabe Takehiro. All rights reserved.
//

import UIKit
import WebKit

class WKWViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.google.com")!
        let request = URLRequest(url: url)
        
        webView.navigationDelegate = self
        webView.load(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension WKWViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //
        if let url = navigationResponse.response.url {
            if UIApplication.shared.canOpenURL(url) {
                print(url.absoluteString)
                if self.count < 1 {
                    decisionHandler(.allow)
                    count = 1
                } else {
                    decisionHandler(.cancel)
                    UIApplication.shared.open(url, options: [:], completionHandler: { result in })
                }
            }
        }
    }
}
