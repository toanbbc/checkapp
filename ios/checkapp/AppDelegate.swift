import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider
import Flutter

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var reactNativeDelegate: ReactNativeDelegate?
  var reactNativeFactory: RCTReactNativeFactory?

  // Flutter engine dùng chung
  lazy var flutterEngine = FlutterEngine(name: "main_engine")

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    let delegate = ReactNativeDelegate()
    let factory = RCTReactNativeFactory(delegate: delegate)
    delegate.dependencyProvider = RCTAppDependencyProvider()

    reactNativeDelegate = delegate
    reactNativeFactory = factory

    window = UIWindow(frame: UIScreen.main.bounds)

    factory.startReactNative(
      withModuleName: "checkapp",
      in: window,
      launchOptions: launchOptions
    )
    
    flutterEngine.run()
    PluginRegistrant.register(with: flutterEngine)

    return true
  }
  func getBridge() -> RCTBridge? {
    return reactNativeFactory?.bridge
  }
  /// Gọi Flutter screen từ bất kỳ chỗ nào
  func openFlutterScreen() {
    let flutterVC = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    flutterVC.modalPresentationStyle = .fullScreen
    window?.rootViewController?.present(flutterVC, animated: true, completion: nil)
  }
}

// MARK: - React Native Delegate

class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
  override func sourceURL(for bridge: RCTBridge) -> URL? {
    self.bundleURL()
  }

  override func bundleURL() -> URL? {
#if DEBUG
    return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
#else
    return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
  }
}
