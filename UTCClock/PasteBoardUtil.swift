//
//  PasteBoardUtil.swift
//  UTCClock
//
//  Created by YAN ZHAO on 3/6/16.
//  Copyright © 2016 Yan Zhao. All rights reserved.
//

import Cocoa

public class PasteBoardUtil {
    private static let pasteBoard = NSPasteboard.generalPasteboard()

    public class func copyToClipboard(value: String) {
        pasteBoard.clearContents()
        pasteBoard.setString(value, forType: NSPasteboardTypeString)
    }
}
