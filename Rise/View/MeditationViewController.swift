//
//  MeditationViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit

class MeditationViewController: UIViewController {

    @IBOutlet weak var meditationLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goBackHomeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "BackHomeViewController") as? BackHomeViewController else {
            return
        }

        // 白いビューを作成
        let whiteView = UIView(frame: UIScreen.main.bounds)
        whiteView.backgroundColor = .white
        whiteView.alpha = 0  // 初期状態では透明に設定
        view.window?.addSubview(whiteView)

        // フェードアウトアニメーション
        UIView.animate(withDuration: 0.25, animations: {
            whiteView.alpha = 1  // 白いビューを完全に不透明にする
        }) { _ in
            // 0.5秒待機
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // フェードインアニメーション
                UIView.transition(with: self.view.window!, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.view.window?.rootViewController = nextViewController
                }) { _ in
                    // 白いビューを削除
                    whiteView.removeFromSuperview()
                }
            }
        }
    }
}
