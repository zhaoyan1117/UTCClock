//
//  TimeViewController.swift
//  UTCClock
//
//  Created by YAN ZHAO on 3/6/16.
//  Copyright © 2016 Yan Zhao. All rights reserved.
//

import Cocoa

class TimeViewController: NSViewController {
    
    @IBOutlet weak var epochInput: NSTextField!
    @IBOutlet weak var utcOutput: NSTextField!
    @IBOutlet weak var pstOutput: NSTextField!
    
    private let pstDateTime = DateTime(timeZone: "PST")
    private let utcDateTime = DateTime(timeZone: "UTC")

    @IBAction func copyCurrentUTCTime(sender: NSButton) {
        PasteBoardUtil.copyToClipboard(utcDateTime.getCurrentTimeStr())
    }
    
    @IBAction func copyCurrentUTCEpoch(sender: NSButton) {
        PasteBoardUtil.copyToClipboard(utcDateTime.getCurrentEpochStr())
    }
    
    @IBAction func convert(sender: NSBundle) {
        if let epoch = Double(epochInput.stringValue) {
            utcOutput.stringValue = utcDateTime.getCurrentTimeStr(epoch)
            pstOutput.stringValue = pstDateTime.getCurrentTimeStr(epoch)
        } else {
            utcOutput.stringValue = DateTime.formatterStr
            pstOutput.stringValue = DateTime.formatterStr
        }
    }
}
