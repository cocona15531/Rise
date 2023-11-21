//
//  TodoViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit

class TodoViewController: UIViewController {
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goMeditationButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "MeditationViewController") as? MeditationViewController else {
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
