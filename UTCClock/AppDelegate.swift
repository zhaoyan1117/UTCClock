//
//  AppDelegate.swift
//  UTCClock
//
//  Created by YAN ZHAO on 10/10/15.
//  Copyright © 2015 Yan Zhao. All rights reserved.
//
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    let pasteBoard = NSPasteboard.generalPasteboard()
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    let formatter = NSDateFormatter()
    let timeZone = "UTC"
    
    override func awakeFromNib() {
        setUpTimer()
    }
    
    func setUpTimer() {
        if let button = statusItem.button {
            button.action = Selector("copyToClipboard")
            button.title = "\(timeZone) \(generateTimeStr())"
        }

        NSTimer.scheduledTimerWithTimeInterval(
            1.0,
            target: self,
            selector: Selector("tick"),
            userInfo: nil,
            repeats: true
        )
    }
    
    func tick() {
        if let button = statusItem.button {
            button.title = "\(timeZone) \(generateTimeStr())"
        }
    }
    
    func generateTimeStr() -> String {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(abbreviation: timeZone);
        return formatter.stringFromDate(NSDate())
    }
    
    func copyToClipboard() {
        pasteBoard.clearContents()
        pasteBoard.writeObjects([generateTimeStr()])
    }
}
