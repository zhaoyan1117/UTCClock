//
//  TimeViewController.swift
//  UTCClock
//
//  Created by YAN ZHAO on 3/6/16.
//  Copyright © 2016 Yan Zhao. All rights reserved.
//

import Cocoa

class TimeViewController: NSViewController {
    private static let MsStr = "ms";
    private static let UsStr = "us";

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
            sender.title = TimeViewController.UsStr
        } else if (sender.title == TimeViewController.UsStr) {
            sender.title = TimeViewController.MsStr
        }
    }
    
    private func convertInternal() {
        if let epoch = getEpochInMs(epochInput.stringValue) {
            utcOutput.stringValue = utcDateTime.getCurrentTimeStr(epoch)
            pstOutput.stringValue = pstDateTime.getCurrentTimeStr(epoch)
        } else {
            utcOutput.stringValue = ""
            pstOutput.stringValue = ""
        }
    }
    
    private func getEpochInMs(epochStr: String) -> Double? {
        if let epoch = Double(epochStr) {
            if (timeUnitInput.title == TimeViewController.MsStr) {
                return epoch
            } else if (timeUnitInput.title == TimeViewController.UsStr) {
                return epoch / 1000
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
