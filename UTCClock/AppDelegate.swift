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
    
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    private let statusItemImage = NSImage(named: "clock")

    private let popover = NSPopover()
    
    private let utcDateTime = DateTime(timeZone: "UTC")
    private var eventMonitor: EventMonitor?
    private var clock: Clock?
    
    override func awakeFromNib() {
        if let button = statusItem.button {
            button.image = statusItemImage
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
    }

    func getClock() -> Clock {
        return clock!
    }

    func getStatusItem() -> NSStatusItem {
        return statusItem
    }

    func getStatusItemImage() -> NSImage? {
        return statusItemImage
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
