//
//  BackHomeViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit

class BackHomeViewController: UIViewController {

    @IBOutlet weak var finalLabel: UILabel!
    @IBOutlet weak var backHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backHomeButton.layer.cornerRadius = 20
    }

    @IBAction func backHomeButtonTapped(_ sender: Any) {
        UIControl().sendAction(NSSelectorFromString("suspend"), to: UIApplication.shared, for: nil)
    }
    
    @IBAction func goFirstScreenButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            return
        }

        // 0.5秒後に画面遷移を実行
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.view.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view.window?.rootViewController = nextViewController
            }, completion: nil)
        }
    }
}
