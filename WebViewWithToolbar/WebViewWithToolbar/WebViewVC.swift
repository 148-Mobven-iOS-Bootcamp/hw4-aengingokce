//
//  ViewController.swift
//  WebViewWithToolbar
//
//  Created by Ahmet Engin Gökçe on 12.01.2022.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let strURL = "https://www.patika.dev/"
    let strHTML = "<html><body p style='color:red' text=\"#FF0000\" face=\"Bookman Old Style, Book Antiqua, Garamond\" size=\"5\"><h1>PATİKA.DEV<h1></body></html>"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for the using goBack and goForward Buttons uncomment the link in below and comment the loadHTMLString.
        //configurationsOfWebView()
        
        webView.loadHTMLString(strHTML, baseURL: nil)
    }
    
    func configurationsOfWebView() {
        guard let myURL = URL(string: strURL) else { return }
        let myUrlRequest = URLRequest(url: myURL)
        webView.load(myUrlRequest)
    }
    
    @IBAction func openInSafariTapped(_ sender: UIBarButtonItem) {
        guard let myURL = URL(string: strURL) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(myURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(myURL)
        }
    }
    
    @IBAction func goBackwardTapped(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardTapped(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

