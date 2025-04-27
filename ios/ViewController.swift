import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let openFlutterButton = UIButton(type: .system)
        openFlutterButton.setTitle("Mở Flutter", for: .normal)
        openFlutterButton.addTarget(self, action: #selector(openFlutter), for: .touchUpInside)
        openFlutterButton.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        view.addSubview(openFlutterButton)
    }

    @objc func openFlutter() {
        FlutterManager.shared.presentFlutter(from: self)
    }
}
