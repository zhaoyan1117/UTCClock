//
//  TimeViewController.swift
//  UTCClock
//
//  Created by YAN ZHAO on 3/6/16.
//  Copyright © 2016 Yan Zhao. All rights reserved.
//

import Cocoa

class TimeViewController: NSViewController {
    private static let SecStr = "sec";
    private static let MsStr = "ms";

    @IBOutlet weak var epochInput: NSTextField!
    @IBOutlet weak var utcOutput: NSTextField!
    @IBOutlet weak var pstOutput: NSTextField!
    @IBOutlet weak var timeUnitInput: NSButton!
    
    private let pstDateTime = DateTime(timeZone: "PST")
    private let utcDateTime = DateTime(timeZone: "UTC")

    @IBAction func copyCurrentUTCTime(sender: NSButton) {
        PasteBoardUtil.copyToClipboard(utcDateTime.getCurrentTimeStr())
    }
    
    @IBAction func copyCurrentUTCEpoch(sender: NSButton) {
        PasteBoardUtil.copyToClipboard(utcDateTime.getCurrentEpochStr())
    }
    
    @IBAction func convertEpochButton(sender: NSButton) {
        convertInternal()
    }

    @IBAction func enterEpochInput(sender: NSTextField) {
        convertInternal()
    }

    @IBAction func quitApp(sender: NSButton) {
        NSApplication.sharedApplication().terminate(self)
    }

    @IBAction func toggleTimeUnit(sender: NSButton) {
        if (sender.title == TimeViewController.MsStr) {
            sender.title = TimeViewController.SecStr
        } else if (sender.title == TimeViewController.SecStr) {
            sender.title = TimeViewController.MsStr
        }
    }
    
    private func convertInternal() {
        if let epoch = getEpochInSec() {
            utcOutput.stringValue = utcDateTime.getCurrentTimeStr(epoch)
            pstOutput.stringValue = pstDateTime.getCurrentTimeStr(epoch)
        } else {
            utcOutput.stringValue = ""
            pstOutput.stringValue = ""
        }
    }
    
    private func getEpochInSec() -> Double? {
        if let epoch = Double(epochInput.stringValue) {
            if (timeUnitInput.title == TimeViewController.SecStr) {
                return epoch
            } else if (timeUnitInput.title == TimeViewController.MsStr) {
                return epoch / 1000
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
