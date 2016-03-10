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

    private static let showMenuBarClockStr = "Show UTC Clock On Menubar"
    private static let hideMenuBarClockStr = "Hide UTC Clock On Menubar"

    @IBOutlet weak var epochInput: NSTextField!
    @IBOutlet weak var utcOutput: NSTextField!
    @IBOutlet weak var pstOutput: NSTextField!
    @IBOutlet weak var timeUnitInput: NSButton!
    
    private let pstDateTime = DateTime(timeZone: "PST")
    private let utcDateTime = DateTime(timeZone: "UTC")

    private let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate

    private var menuBarClockOn = false

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

    @IBAction func toggleUTCClockOnMenuBar(sender: NSButton) {
        if (menuBarClockOn) {
            hideUTCClockOnMenuBar(sender)
            menuBarClockOn = false
        } else {
            showUTCClockOnMenuBar(sender)
            menuBarClockOn = true
        }
    }

    private func showUTCClockOnMenuBar(toggleBtn: NSButton) {
        appDelegate.closePopover(nil)
        appDelegate.getStatusItem().image = nil
        appDelegate.getStatusItem().length = NSVariableStatusItemLength
        appDelegate.getStatusItem().title = utcDateTime.getCurrentTimeStr()
        appDelegate.getClock().start()

        toggleBtn.title = TimeViewController.hideMenuBarClockStr
    }

    private func hideUTCClockOnMenuBar(toggleBtn: NSButton) {
        appDelegate.closePopover(nil)
        appDelegate.getClock().stop()
        appDelegate.getStatusItem().title = nil
        appDelegate.getStatusItem().length = NSSquareStatusItemLength
        appDelegate.getStatusItem().image = appDelegate.getStatusItemImage()

        toggleBtn.title = TimeViewController.showMenuBarClockStr
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
