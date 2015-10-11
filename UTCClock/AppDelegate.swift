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
    let formatterStr = "yyyy-MM-dd HH:mm:ss"
    let timeZone = "UTC"
    
    override func awakeFromNib() {
        setUpStatusBar()
        setUpTimer()
    }
    
    func setUpStatusBar() {
        if let button = statusItem.button {
            button.action = Selector("copyToClipboard:")
            button.title = generateTimeStr()
            button.font = NSFont(name: "Eurostile", size: 15)
            button.alignment = NSTextAlignment.Center
        }
    }

    func setUpTimer() {
        formatter.dateFormat = formatterStr
        formatter.timeZone = NSTimeZone(abbreviation: timeZone);

        NSTimer.scheduledTimerWithTimeInterval(
            1.0,
            target: self,
            selector: Selector("tick"),
            userInfo: nil,
            repeats: true
        )
    }

    func generateTimeStr() -> String {
        return formatter.stringFromDate(NSDate())
    }

    func tick() {
        if let button = statusItem.button {
            button.title = generateTimeStr()
        }
    }

    func copyToClipboard(sender: NSStatusBarButton) {
        pasteBoard.clearContents()
        pasteBoard.setString(sender.title, forType: NSPasteboardTypeString)
    }
}
