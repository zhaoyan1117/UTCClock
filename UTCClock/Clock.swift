//
//  Clock.swift
//  UTCClock
//
//  Created by YAN ZHAO on 3/6/16.
//  Copyright © 2016 Yan Zhao. All rights reserved.
//

import Cocoa

public class Clock: NSObject {
    let event: () -> ();
    var timer: NSTimer?;
    
    public init(event: () -> ()) {
        self.event = event;
    }
    
    public func start() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(
            1.0,
            target: self,
            selector: Selector("tick"),
            userInfo: nil,
            repeats: true
        )
    }
    
    public func stop() {
        self.timer?.invalidate();
        self.timer = nil;
    }
    
    func tick() {
        event()
    }
}
