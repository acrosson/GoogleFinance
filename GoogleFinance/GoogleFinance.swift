//
//  GoogleFinance.swift
//  GoogleFinance
//
//  Created by Alexander Crosson on 7/24/15.
//  Copyright (c) 2015 Alexander Crosson. All rights reserved.
//

import Alamofire
import Foundation

// Extend String to include toDouble() function
extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}

typealias ServiceResponse = (Dictionary<String, String>?, NSError?) -> Void

class GoogleFinance {
    
    let kGOOGLEURLSTRING_CONSTANT:String = "http://www.google.com/finance/info?q="
    
    func parseStringToDictionary(response:String) -> Dictionary<String,String> {
        
        // Remove \n line break q
        var response = response.stringByReplacingOccurrencesOfString("\n", withString: "")
        
        // Remove //
        response = response.stringByReplacingOccurrencesOfString("// ", withString: "")
        
        // Encode in UTF 8
        var data: NSData = response.dataUsingEncoding(NSUTF8StringEncoding)!
        var error: NSError?
        
        // JSON Serialize
        let json: NSArray? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error) as? NSArray
        
        // Return as Dictionary
        var dict = [:]
        if (json?.objectAtIndex(0) is Dictionary<String,String>) {
            var dict: Dictionary = json?.objectAtIndex(0) as! Dictionary<String,String>
            return dict
        }
        
        return dict as! Dictionary<String, String>
    }
    
    func fetchQuoteForTicker(ticker:String, onCompletion: ServiceResponse) -> Void {
        var url = kGOOGLEURLSTRING_CONSTANT+ticker
        Alamofire.request(.GET, url, parameters: nil)
            .responseString { (request, response, string, error) in
                if (error == nil) {
                    
                    if let string = string {
                        var dict = self.parseStringToDictionary(string)
                        
                        onCompletion(dict, error)
                    } else {
                        onCompletion(nil, error)
                    }
                } else {
                    onCompletion(nil, error)
                }
        }
    }
}