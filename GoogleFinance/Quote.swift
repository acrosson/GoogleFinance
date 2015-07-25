//
//  Quote.swift
//  GoogleFinance
//
//  Created by Alexander Crosson on 7/24/15.
//  Copyright (c) 2015 Alexander Crosson. All rights reserved.
//

import Foundation

class Quote: NSObject {
    
    var ticker: String?
    var price: Double?
    var changePrice: Double?
    var changePercent: Double?
    var afterHoursPrice: Double?
    var afterHoursChangePrice: Double?
    var afterHoursChangePercent: Double?
    var time: NSDate?
    
    init(dict: Dictionary<String,String>) {
        
        ticker = dict["t"]
        price = dict["l"]!.toDouble()
        changePrice = dict["c_fix"]!.toDouble()
        changePercent = dict["cp_fix"]!.toDouble()
        afterHoursPrice = dict["el_fix"]!.toDouble()
        afterHoursChangePrice = dict["ec_fix"]!.toDouble()
        afterHoursChangePercent = dict["ecp_fix"]!.toDouble()
        super.init()
        
        time = formatDate(dict["lt_dts"]!)
    }
    
    func formatDate(date: String) -> NSDate {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.dateFromString(date)!
    }
}