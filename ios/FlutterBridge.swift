import Foundation
import Flutter
import UIKit
import React

@objc(FlutterBridge)
class FlutterBridge: NSObject {

    private var backChannel: FlutterMethodChannel?

    @objc
    func presentFlutter(_ message: NSString) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let flutterEngine = appDelegate.flutterEngine
            let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
            flutterViewController.modalPresentationStyle = .fullScreen

            // 1. Setup flutter_back_channel
            let backChannel = FlutterMethodChannel(name: "flutter_back_channel", binaryMessenger: flutterViewController.binaryMessenger)
            backChannel.setMethodCallHandler { [weak flutterViewController, weak self] (call, result) in
                if call.method == "finishActivity" {
                    if let arguments = call.arguments as? [String: Any] {
                        print("[FlutterBridge] Received data from Flutter: \(arguments)")

                        // 🔥 Gửi event về React Native
                        self?.sendEventToReactNative(data: arguments)
                    }

                    DispatchQueue.main.async {
                        flutterViewController?.dismiss(animated: true, completion: nil)
                    }
                    result(nil)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
            self.backChannel = backChannel

            // 2. Gửi setup_config
            let setupConfigChannel = FlutterMethodChannel(name: "setup_config", binaryMessenger: flutterViewController.binaryMessenger)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let jsonString = "{\"message\": \"\(message)\"}"
                setupConfigChannel.invokeMethod("sendData", arguments: jsonString)
                print("[FlutterBridge] Sent config to Flutter: \(jsonString)")
            }

            // 3. Present FlutterViewController
          if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
             let window = windowScene.windows.first,
             let rootVC = window.rootViewController {
              rootVC.present(flutterViewController, animated: true)
          }
        }
    }
    
    private func sendEventToReactNative(data: [String: Any]) {
        if let bridge = (UIApplication.shared.delegate as? AppDelegate)?.getBridge() {
            if let eventEmitter = bridge.module(forName: "RCTDeviceEventEmitter") as? RCTEventEmitter {
                eventEmitter.sendEvent(withName: "FlutterResultEvent", body: data)
            } else {
                print("[FlutterBridge] Cannot find RCTDeviceEventEmitter")
            }
        } else {
            print("[FlutterBridge] Bridge not available")
        }
    }

    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
