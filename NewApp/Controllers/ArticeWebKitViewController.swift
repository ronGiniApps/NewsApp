//
//  ArticeWebKitViewController.swift
//  NewApp
//
//  Created by Ron Haimovich on 02/05/2018.
//  Copyright © 2018 Ron Haimovich. All rights reserved.
//

import UIKit
import WebKit

class ArticeWebKitViewController: UIViewController,WKUIDelegate,WKNavigationDelegate{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var webView: WKWebView!
    var articleUrl:String?
    let myIndicator:UIActivityIndicatorView = UIActivityIndicatorView (activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillLayoutSubviews() {
        myIndicator.center = self.view.center
        myIndicator.color = UIColor.gray
        myIndicator.startAnimating()
        myIndicator.hidesWhenStopped = true
        self.view.addSubview(myIndicator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //activityIndicator.startAnimating()
        
        if articleUrl != nil{
            let url = URL(string: articleUrl!)
            let myRequest = URLRequest(url: url!)
            webView.load(myRequest)
        }
        
        // Do any additional setup after loading the view.
    }
   
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
        myIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
