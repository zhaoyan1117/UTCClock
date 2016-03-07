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
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    let popover = NSPopover()
    
    let utcDateTime = DateTime(timeZone: "UTC")
    var eventMonitor: EventMonitor?
    var clock: Clock?
    
    override func awakeFromNib() {
        if let button = statusItem.button {
            button.action = Selector("togglePopover:")
            button.font = NSFont(name: "Eurostile", size: 15)
            button.alignment = NSTextAlignment.Center
        }
        
        popover.contentViewController = TimeViewController(nibName: "TimeViewController", bundle: nil)
        
        eventMonitor = EventMonitor(mask: [NSEventMask.LeftMouseDownMask, NSEventMask.RightMouseDownMask]) {
            [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        
        clock = Clock() {
            [unowned self] in
            if let button = self.statusItem.button {
                button.title = self.utcDateTime.getCurrentTimeStr()
            }
        }
        clock?.start()
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}
