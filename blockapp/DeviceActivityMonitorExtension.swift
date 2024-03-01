//
//  DeviceActivityMonitorExtension.swift
//  blockapp
//
//  Created by apple on 3/1/24.
//

import UIKit
import MobileCoreServices
import ManagedSettings
import DeviceActivity

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    
    let store = ManagedSettingsStore()

    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
        print(">>>>> interval did start")
        let model = MyModel.shared
        let applications = model.selectionToDiscourage.applicationTokens
        let categories = model.selectionToDiscourage.categoryTokens
        let webCategories = model.selectionToDiscourage.webDomainTokens
        print(">>>>> applications =")
        print(applications)
        if applications.isEmpty {
            print("== No applications to restrict")
        } else {
            print("== Have applications to restrict")
        }
        
        if categories.isEmpty {
            print("== No categories to restrict")
        }
        
        if webCategories.isEmpty {
            print("== No web categories to restrict")
        }
        
        store.shield.applications = applications.isEmpty ? nil : applications
        store.dateAndTime.requireAutomaticDateAndTime = true
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        store.shield.applications = nil
        store.dateAndTime.requireAutomaticDateAndTime = false
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
