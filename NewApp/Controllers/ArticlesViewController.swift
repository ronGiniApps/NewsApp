//
//  ArticlesViewController.swift
//  NewApp
//
//  Created by Ron Haimovich on 03/05/2018.
//  Copyright © 2018 Ron Haimovich. All rights reserved.
//

import UIKit
import SDWebImage



protocol ShareTapped : class {
    func didPressButton(_ sender: String)
}


class ArticlesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ShareTapped{
    func didPressButton(_ sender: String) {
        
        let text = "Hey look at this article!:\(sender)"
        let shareAll = [text]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.postToFacebook,UIActivityType.mail,UIActivityType.message,UIActivityType.openInIBooks]
        self.present(activityViewController, animated: true, completion: nil)
        UIApplication.shared.backgroundRefreshStatus
    }
    
    
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func openMenuClose(_ sender: UIBarButtonItem) {
        if isMenuOpen{
            sideMenu.layer.shadowOpacity = 0
            sideMenu.layer.shadowRadius = 0
            self.leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.leadingConstraint.constant = -250
                self.view.layoutIfNeeded()
            }
        }else{
            sideMenu.layer.shadowOpacity = 1
            sideMenu.layer.shadowRadius = 6
            self.leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        isMenuOpen = !isMenuOpen
    }
    
    
    let myIndicator:UIActivityIndicatorView = UIActivityIndicatorView (activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var isMenuOpen = false
    var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        ParseJson.getArticlesFromJson { (articlesFromJson) in
            self.articles = articlesFromJson
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var row = indexPath.row + 1
        
        let articleCell =  Bundle.main.loadNibNamed("ArticleTableViewCell", owner: self, options: nil)?.first as! ArticleTableViewCell
        
        let everyThirdArticlCell =  Bundle.main.loadNibNamed("EveryThirdTableViewCell", owner: self, options: nil)?.first as! EveryThirdTableViewCell
        
        
        articleCell.delegate = self
        everyThirdArticlCell.delegate = self
        
        
        if row % 3 == 0 {
            everyThirdArticlCell.setArticleDetails(article: articles[indexPath.row])
            return everyThirdArticlCell
            
        }else{
            row = row - (row/3)
            row -= 1
            
            articleCell.setArticleDetails(article: articles[indexPath.row])
            return articleCell
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "articleurlsegue", sender: articles[indexPath.row].url)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleurlsegue"{
            if let dest = segue.destination as? ArticeWebKitViewController,let url = sender as? String{
                dest.articleUrl = url
                print(url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var row = indexPath.row + 1
        
        if row % 3 == 0{
            return 125
        }else{
            row = row - (row/3)
            row -= 1
            return 300
        }
    }
}
extension Date{
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


