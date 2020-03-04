//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by Connor on 3/4/20.
//  Copyright © 2020 Connor Sullivan. All rights reserved.
//

import Foundation
import UserNotifications

struct LocalNotificationManager {
    static func authorizeLocalNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge,]) { (granted, error) in
            guard error == nil else {
                return
            }
            if granted {
                
            } else {
                //TODO: Put an alert in here
            }
        }
    }
    
    static func setCalendarNotification (title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        //create content:
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        //create trigger:
        var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //create request:
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        //register request with notification center:
        UNUserNotificationCenter.current().add(request) { (error) in
        }
        return notificationID
    }
}
