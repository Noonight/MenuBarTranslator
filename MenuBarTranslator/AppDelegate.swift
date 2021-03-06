//
//  AppDelegate.swift
//  FirstMenuBarApp
//
//  Created by Aiur on 26.11.2020.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {

    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var statusBarMenu: NSMenu!
    var settingsPopover: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let context = CoreDataHelper.shared.context
        
        let contentView = MainView().environment(\.managedObjectContext, context)
        
        let settingsView = SettingsView()
        
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 250)
        
        popover.behavior = .transient
        popover.appearance = NSAppearance(named: NSAppearance.Name.darkAqua)
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        self.popover.contentViewController?.view.window?.becomeKey()
        
        let setPopover = NSPopover()
        setPopover.contentSize = NSSize(width: 300, height: 150)
        setPopover.behavior = .transient
        setPopover.appearance = NSAppearance(named: NSAppearance.Name.darkAqua)
        setPopover.contentViewController = NSHostingController(rootView: settingsView)
        self.settingsPopover = setPopover
        self.settingsPopover.contentViewController?.view.window?.becomeKey()
        
        let menu = NSMenu(title: "Status Bar Menu")
        menu.delegate = self
        menu.addItem(NSMenuItem(title: "Settings",
                                action: #selector(openSettings(_:)),
                                keyEquivalent: ""))
        menu.addItem(NSMenuItem(
                        title: "Quit",
                        action: #selector(closeApp(_:)),
                        keyEquivalent: ""))
        
        self.statusBarMenu = menu
        
        // Create status bar item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "translateColorfull")
            button.action = #selector(togglePopover(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    
    // MARK: - Actions
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            let event = NSApp.currentEvent!
            if event.type == NSEvent.EventType.leftMouseUp {
                if self.popover.isShown || self.settingsPopover.isShown {
                    self.popover.performClose(sender)
                    self.settingsPopover.performClose(sender)
                } else {
                    self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            } else if event.type == NSEvent.EventType.rightMouseUp {
                statusBarItem.menu = statusBarMenu
                statusBarItem.button?.performClick(nil)
            }
        }
    }
    
    @objc func closeApp(_ sender: NSMenu) {
        NSApplication.shared.terminate(self)
    }
    
    @objc func openSettings(_ sender: NSMenu) {
        if let button = self.statusBarItem.button {
            if self.settingsPopover.isShown {
                self.settingsPopover.performClose(sender)
            } else {
                self.settingsPopover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    @objc func menuDidClose(_ menu: NSMenu) {
        statusBarItem.menu = nil
    }

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = CoreDataHelper.shared.context

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return CoreDataHelper.shared.context.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = CoreDataHelper.shared.context
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }

}

