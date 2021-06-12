//
//  MainPopoverTracker.swift
//  MenuBarTranslator
//
//  Created by Aiur on 13.06.2021.
//

import Cocoa
import SwiftUI

protocol PopoverTrackerDelegate {
    func onWillShow()
}

protocol PopoverTrackerProtocol {
    var popover: NSPopover { get set }
    var delegate: PopoverTrackerDelegate? { get set }
    
    func registerObservers()
}

class MainPopoverTracker: PopoverTrackerProtocol {
    var popover: NSPopover
    var delegate: PopoverTrackerDelegate?
    
    private let notificationCenter = NotificationCenter.default
    
    init(popover: NSPopover) {
        self.popover = popover
    }
    
    func registerObservers() {
        notificationCenter.addObserver(self, selector: #selector(onWillShow(_:)), name: NSPopover.willShowNotification, object: popover)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc private func onWillShow(_ notification: Notification) {
        delegate?.onWillShow()
    }
}
