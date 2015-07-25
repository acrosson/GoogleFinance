//
//  ViewController.swift
//  GoogleFinance
//
//  Created by Alexander Crosson on 7/24/15.
//  Copyright (c) 2015 Alexander Crosson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let googleFinance = GoogleFinance()
        let ticker = "TWTR"
        
        googleFinance.fetchQuoteForTicker(ticker, onCompletion: { (quote:Dictionary<String, String>?, error:NSError?) -> Void in
            if (quote) != nil {
                let q = Quote(dict: quote!)
                println("\(q.ticker!)")
                println("Last: \(q.price!) \(q.changePrice!) \(q.changePercent!)")
                println("After Hours: \(q.afterHoursPrice!) \(q.afterHoursChangePrice!) \(q.afterHoursChangePercent!)")
                println("\(q.time!)")
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

