//
//  DateTime.swift
//  UTCClock
//
//  Created by YAN ZHAO on 3/6/16.
//  Copyright © 2016 Yan Zhao. All rights reserved.
//

import Cocoa

public class DateTime {
    private let formatter : NSDateFormatter = NSDateFormatter()
    public static let formatterStr : String = "yyyy-MM-dd HH:mm:ss"
    
    public init(timeZone: String) {
        self.formatter.dateFormat = DateTime.formatterStr
        self.formatter.timeZone = NSTimeZone(abbreviation: timeZone);
    }
    
    func getCurrentTimeStr() -> String {
        return formatter.stringFromDate(NSDate())
    }
    
    func getCurrentTimeStr(epoch: Double) -> String {
        return formatter.stringFromDate(NSDate(timeIntervalSince1970: epoch))
    }
    
    func getCurrentEpochStr() -> String {
        return String(format: "%.0f", NSDate().timeIntervalSince1970)
    }
}
