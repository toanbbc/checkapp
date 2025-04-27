import Flutter
import flutter_local_notifications
import shared_preferences_foundation
import url_launcher_ios

class PluginRegistrant {
  static func register(with registry: FlutterPluginRegistry) {
    if let registrar = registry.registrar(forPlugin: "FlutterLocalNotificationsPlugin") {
        FlutterLocalNotificationsPlugin.register(with: registrar)
    }
    if let registrar = registry.registrar(forPlugin: "SharedPreferencesPlugin") {
        SharedPreferencesPlugin.register(with: registrar)
    }
    if let registrar = registry.registrar(forPlugin: "UrlLauncherPlugin") {
        URLLauncherPlugin.register(with: registrar)
    }
  }
}
