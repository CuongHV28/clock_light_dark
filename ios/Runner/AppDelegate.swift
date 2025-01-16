import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        UNUserNotificationCenter.current().delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let alarmMessage = userInfo["ALARM_MESSAGE"] as? String {
            // Handle notification tap
            let flutterViewController = window?.rootViewController as! FlutterViewController
            let methodChannel = FlutterMethodChannel(name: "com.example.channel", binaryMessenger: flutterViewController.binaryMessenger)
            methodChannel.invokeMethod("showAlarmDialog", arguments: alarmMessage)
        }
        completionHandler()
    }
}
