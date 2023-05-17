
# Qiitaの記事のサンプルです
https://qiita.com/Imael/items/fe7edc26381be1176e5b
# はじめに
プッシュ通知について何も知らなかったのでメモです

# ローカル通知とリモート通知の違い
#### ローカル通知：この通知はユーザーのデバイス上のアプリケーション自体から直接送信されます。例えば、特定の時間になったらリマインダーを表示するなど


#### リモート通知（またはプッシュ通知）：これらの通知は、サーバーなどのリモートシステムからデバイスへ送信されます。例えば、新しいメールが来たとき、ソーシャルメディアで新しいいいねがあったとき、またはアプリの新機能やキャンペーンなどの情報をユーザーに知らせるときなど

ローカル通知はサーバ用意しなくても通知ができるってことです

# UserNotifications Framework
UserNotifications Framework：このフレームワークを使用すると、ローカル通知やリモート通知をスケジュールし、表示することができます

https://developer.apple.com/documentation/usernotifications


# できるもの
#### 通知を許可するアラートがでて
<img width="150" alt="Simulator Screen Shot - iPhone 14 Pro - 2023-05-17 at 20.15.37.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2883687/c08a337f-0f47-7d5f-08e8-e08c0964a23e.png">


#### Buttonをタップすると

<img width="150" alt="Simulator Screen Shot - iPhone 14 Pro - 2023-04-21 at 11.58.16.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2883687/ccedefc0-6f80-d3a7-f8b4-5b1f107c8feb.png">


#### 5秒後にこのアプリ外で通知がでます
<img width="150" alt="Simulator Screen Shot - iPhone 14 Pro - 2023-05-17 at 20.15.37.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2883687/196d4af5-f0a0-6a9d-f3d3-33cf89d32f60.png">


# 最小実装
#### Main.storyboard
![スクリーンショット 2023-05-17 20.22.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2883687/4b07f58c-e767-6157-6180-51ec9963d0a7.png)

#### ViewContoller
```swift
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

```

## このサンプルだと大きく分けて4つの部品があります
1､通知許可を求める
```swift
let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("通知許可が得られました")
            }
```
2､通知内容を設定
```swift
let content = UNMutableNotificationContent()
        content.title = "通知でーす"
        content.body = "こんちわ"
        content.sound = UNNotificationSound.default
```
3､いつ通知するか決める
```swift
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
```
4､通知を登録
```swift
let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("通知リクエストの追加に失敗しました: \(error.localizedDescription)")
            }
```
# 終わりに
最小実装なので全部ViewControllerに書きました｡
通知許可を求めるところなんかはアプリ起動時とかにアラートがでるアプリが多そうですね!
間違ってたら教えて下さい!

# 参考

https://developer.apple.com/documentation/usernotifications



https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/index.html#//apple_ref/doc/uid/TP40008194-CH3-SW1

https://qiita.com/aokiplayer/items/3f02453af743a54de718

https://ios-docs.dev/unusernotificationcenter/

