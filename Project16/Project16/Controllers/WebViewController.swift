//
//  WebViewController.swift
//  Project16
//
//  Created by Irakli Sokhaneishvili on 12.02.22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    var website: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard website != nil else {
            print("Website not set")
            navigationController?.popViewController(animated: true)
            return
        }
        
        if let url = URL(string: website) {
            webView.load(URLRequest(url: url))
        }
    }
    


}
