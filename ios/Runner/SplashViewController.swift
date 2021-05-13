import UIKit
import Lottie

public class SplashViewController: UIViewController {
    private var animationView: AnimationView?
    
    public override func viewDidAppear(_ animated: Bool) {
        animationView = .init(name: "splash_animation")
        animationView!.frame = view.bounds
        animationView!.contentMode = .center
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 1.0
        view.addSubview(animationView!)
        animationView!.play {
            (finished) in self.startFlutterApp()
        }
    }
    
    private func startFlutterApp() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let flutterEngine = appDelegate.flutterEngine
        let flutterViewController = FlutterViewController(
            engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.modalPresentationStyle = .custom
        flutterViewController.modalTransitionStyle = .crossDissolve
        present(flutterViewController, animated: true, completion: nil)
    }
}
