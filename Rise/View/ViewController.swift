//
//  ViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage1: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startButton.layer.cornerRadius = 20
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "TodoViewController") as? TodoViewController else {
            return
        }
        
        // 0.5秒後に画面遷移を実行
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.view.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view.window?.rootViewController = nextViewController
            }, completion: nil)
        }
    }
    
    
    @IBAction func goSetting(_ sender: Any) {
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
}

