import UIKit
import Lottie

public class SplashViewController: UIViewController {
    public override func viewDidAppear(_ animated: Bool) {
        let animationView: AnimationView = .init(name: "splash_animation")
        animationView.frame = CGRect(origin: .zero, size: CGSize(width: 250.0, height: 250))
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 2.0
        animationView.play {
            (finished) in self.startFlutterApp()
        }
        view.addSubview(animationView)
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
