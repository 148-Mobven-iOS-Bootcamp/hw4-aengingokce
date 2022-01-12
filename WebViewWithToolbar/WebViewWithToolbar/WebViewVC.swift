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
    let strHTML = "<html><body><p>Hello!</p></body></html>"
    let strHTML2 = "<html><body p style='color:red' text=\"#FF0000\" face=\"Bookman Old Style, Book Antiqua, Garamond\" size=\"5\">%@</body></html>"
    let strHTML3 = "<html><body><h1>My First Heading</h1><p>My first paragraph.</p></body></html>"

    
    let strHTML4 = "<html><body><h1 style='background-color:Tomato;'>Tomato</h1><h1 style='background-color:Orange;'>Orange</h1><h1 style='background-color:DodgerBlue;'>DodgerBlue</h1><h1 style='background-color:MediumSeaGreen;'>MediumSeaGreen</h1><h1 style='background-color:LightGray;'>LightGray</h1></body></html>"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configurationsOfWebView()
        
        webView.loadHTMLString(strHTML4, baseURL: nil)
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

