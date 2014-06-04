//
//  WebViewController.swift
//  KMRSS
//
//  Created by Kieran McGrady on 04/06/2014.
//  Copyright (c) 2014 HotRod Software. All rights reserved.
//

import Foundation
import UIKit

class WebViewController : UIViewController, UIWebViewDelegate {

    @IBOutlet var webView : UIWebView
    var link = ""

    override func viewDidAppear(animated: Bool)  {
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL.URLWithString(link)))
        
    }

}