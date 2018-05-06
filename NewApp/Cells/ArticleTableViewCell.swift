//
//  ArticleTableViewCell.swift
//  NewApp
//
//  Created by Ron Haimovich on 02/05/2018.
//  Copyright © 2018 Ron Haimovich. All rights reserved.
//

import UIKit
import SDWebImage


class ArticleTableViewCell: UITableViewCell{
    
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var articleSubtitle: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    var url:String = ""
    weak var delegate:ShareTapped?
    
    @IBAction func shareAction(_ sender: UIButton) {
        if !url.isEmpty{
            delegate?.didPressButton(url)
            print(url)
        }else{
            print("no url")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setArticleDetails(article:Article){
      
    
        articleDate.text = SetCells.setDate(article: article)
        
        articleTitle.text = article.title
        articleSubtitle.text = article.subTitle
        articleImage.sd_setImage(with: URL(string:article.imgUrl!), placeholderImage: #imageLiteral(resourceName: "imgplaceholder"), options: [], completed: nil)
        articleAuthor.text = article.author
        cellView.layer.cornerRadius = 5
        cellView.layer.masksToBounds = true
        articleImage.layer.cornerRadius = 5
        articleImage.layer.masksToBounds = true
        url = article.url
    }
}
