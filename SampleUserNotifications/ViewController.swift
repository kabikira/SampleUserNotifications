//
//  ViewController.swift
//  SampleUserNotifications
//
//  Created by koala panda on 2023/05/17.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet private weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 通知許可を求める
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("通知許可が得られました")
            }
        }
        button.setTitle("ローカル通知", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        


    }

    @objc func buttonTapped() {
        // 通知内容を設定
        let content = UNMutableNotificationContent()
        content.title = "通知でーす"
        content.body = "こんちわ"
        content.sound = UNNotificationSound.default

        // 5秒後に通知する
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // 通知リクエストを作成
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)

        // 通知センターに通知リクエストを登録
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("通知リクエストの追加に失敗しました: \(error.localizedDescription)")
            }
        }
    }
}

