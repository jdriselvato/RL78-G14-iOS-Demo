//
//  ViewModel.swift
//  rn78
//
//  Created by John on 7/27/15.
//  Copyright (c) 2015 Flare Labs. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    var model: Model?
    
    var queue: dispatch_queue_t?
    var timer: dispatch_source_t?

    var fetchedDweetObject = Observable(DweetObject.emptyDweet()) // ViewController Binds to this
    
    init(model: Model) {
        self.model = model
        super.init()
        self.startConnectionTimer(true)
        
        self.model?.dweetObject.bind(self) { [unowned self] in
            self.fetchedDweetObject.value = $0 // Changes when Model.swift get's a complete dweet
        }
    }
    
    func startConnectionTimer(state: Bool) {
        let seconds = 4.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        self.queue = dispatch_queue_create("myTimer", nil);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
        dispatch_source_set_timer(self.timer!, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
        
        dispatch_source_set_event_handler(self.timer!) {
            dispatch_async(dispatch_get_main_queue(), {
                self.model?.getLatestDweet() // Asks Model.swift to get latest Dweet
            })
        }
        dispatch_resume(self.timer!)
    }
    
    func callBleep() {
        self.model?.sendBleepDweet()
    }
}