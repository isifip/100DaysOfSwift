//
//  ViewController.swift
//  Project21
//
//  Created by Irakli Sokhaneishvili on 23.03.22.
//

import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yes")
            } else {
                print("No")
            }
        }
    }
    
    // challenge 2
    @objc func scheduleLocal(delaySeconds: TimeInterval) {
        
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delaySeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let delay = UNNotificationAction(identifier: "delay", title: "Remind me later", options: .authenticationRequired)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, delay], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            // Challenge 1
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                let ac = UIAlertController(title: "Swipe", message: "The user swiped", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            case "show":
                let ac = UIAlertController(title: "Button", message: "The user tapped TELL ME MORE button", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            // Challenge 2
            case "delay":
                scheduleLocal(delaySeconds: 86400)
            default:
                break
            }
        }
        completionHandler()
    }
    

}

