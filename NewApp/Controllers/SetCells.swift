//
//  SetCells.swift
//  NewApp
//
//  Created by Ron Haimovich on 06/05/2018.
//  Copyright © 2018 Ron Haimovich. All rights reserved.
//

import UIKit

class SetCells: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    static func setDate(article:Article)->String{
        let isoDate = article.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "he_IL") as Locale?
        let date = dateFormatter.date(from: isoDate!)
        return (date?.toString(dateFormat: isoDate!))!
        
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
