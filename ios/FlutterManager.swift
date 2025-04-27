import Flutter

class FlutterManager {
    static let shared = FlutterManager()

    private(set) var flutterEngine: FlutterEngine?

    private init() {
        flutterEngine = FlutterEngine(name: "main_engine")
        flutterEngine?.run()
    }

    func presentFlutter(from viewController: UIViewController) {
        guard let engine = flutterEngine else { return }
      print("hihi hihii hihihi");
        let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen
        viewController.present(flutterVC, animated: true, completion: nil)
    }
}
