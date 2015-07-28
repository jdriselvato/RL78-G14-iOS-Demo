//
//  Model.swift
//  rn78
//
//  Created by John on 7/27/15.
//  Copyright (c) 2015 Flare Labs. All rights reserved.
//

import Foundation

class Model: NSObject, NSURLConnectionDataDelegate {
    let thing: String = "cowardly-friction" //REPLACE WITH YOUR "MY-THING"
    var connection: NSURLConnection?
    
    var dweetObject = Observable(DweetObject.emptyDweet()) //Observe the object
    
    func getLatestDweet() {
        let URL = NSURL(string: "https://dweet.io/get/latest/dweet/for/\(thing)")
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: URL!)
        self.connection = NSURLConnection(request: request, delegate: self)
    }
    
    func sendBleepDweet() {
        let URL = NSURL(string: "https://dweet.io/dweet/for/\(thing)-send?beep=true&callback=dweetCallback.callback0")
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: URL!)
        self.connection = NSURLConnection(request: request, delegate: self)    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        let json = JSON(data: data, options: nil, error: nil) //NSASCIIStringEncoding
        
        self.dweetObject.value = DweetObject.dweet(json) //Observed object changed
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        // can check HTTP response (404, 200, etc)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        println("ERROR: \(error)")
    }
}