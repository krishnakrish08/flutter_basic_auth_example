import Flutter
import UIKit
import flutter_appauth

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      if (FlutterAppAuthPlugin.shouldHandle(url)) {
        return FlutterAppAuthPlugin.handle(url)
      }
      return super.application(app, open: url, options: options)
    }
}
