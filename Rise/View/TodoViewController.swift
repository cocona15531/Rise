//
//  TodoViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit

class TodoViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var todoTextView: UITextView!
    @IBOutlet weak var goMeditationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTextView.delegate = self

        goMeditationButton.layer.cornerRadius = 20
//        NotificationCenter.default.addObserver(self,
//                                                selector: #selector(keyboardWillShow),
//                                                name: UIResponder.keyboardWillShowNotification,
//                                                object: nil)
//         NotificationCenter.default.addObserver(self,
//                                                selector: #selector(keyboardWillHide),
//                                                name: UIResponder.keyboardWillHideNotification,
//                                                object: nil)
        
        // MARK: - 閉じるボタン
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // スペーサー構築
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン構築
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action:#selector(closeButtonTapped))

        toolBar.items = [spacer, closeButton]
        todoTextView.inputAccessoryView = toolBar
        // MARK: - 閉じるボタン
    }
    
    // MARK: - 閉じるボタン
    @objc  func closeButtonTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func goMeditationButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "MeditationViewController") as? MeditationViewController else {
            return
        }

        // 0.5秒後に画面遷移を実行
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.view.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view.window?.rootViewController = nextViewController
            }, completion: nil)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardHeight = notification.keyboardHeight,
              let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }
        
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            // アニメーションさせたい実装を行う
//            self.ViewButtonConstraint.constant = keyboardHeight * 0.9
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }
        
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            let screenHeight = UIScreen.main.bounds.height
            let newHeight = screenHeight * 0.25  // 高さを画面の半分にする例
//            self.ViewButtonConstraint.constant = newHeight
            self.navigationController?.navigationBar.isHidden = false
        }
    }
}

extension Notification {
    // キーボードの高さ
    var keyboardHeight: CGFloat? {
        return (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }
    // キーボードのアニメーション時間
    var keybaordAnimationDuration: TimeInterval? {
        return self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
    }
    // キーボードのアニメーション曲線
    var keyboardAnimationCurve: UInt? {
        return self.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
    }
}
