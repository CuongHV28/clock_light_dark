import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UNUserNotificationCenterDelegate {
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

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let alarmMessage = userInfo["ALARM_MESSAGE"] as? String {
            // Handle notification tap
            let flutterViewController = window?.rootViewController as! FlutterViewController
            flutterViewController.invokeMethod("showAlarmDialog", arguments: alarmMessage)
        }
        completionHandler()
    }
}