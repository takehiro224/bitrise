//
//  NotificationViewController.swift
//  Sample
//
//  Created by Watanabe Takehiro on 2018/03/05.
//  Copyright © 2018年 Watanabe Takehiro. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let osVersion = UIDevice.current.systemVersion
        if osVersion < "8.0" {
            print(osVersion)
        } else {
            print(osVersion)
        }
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                print("authorized")
            case .denied:
                print("denied")
            case .notDetermined:
                print("notDetermined")
            }
        }
        // 通知を使用可能にする設定
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(granted, error) in
            // エラー処理
            if let e = error {
                print(e)
            } else {
                if granted {
                    // 許可
                } else {
                    // 拒否
                }
            }
        })
        
        // 通知自体の設定
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "通知タイトル", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "通知するメッセージ", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        // アプリを起動して5秒後に通知を送る
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "my-notification", content: content, trigger: trigger)
        
        // 通知を登録
        center.add(request) { (error : Error?) in
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
