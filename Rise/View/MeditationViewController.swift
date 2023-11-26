//
//  MeditationViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit
import AudioToolbox

class MeditationViewController: UIViewController {

    @IBOutlet weak var meditationLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var goBackHomeButton: UIButton!
    
    var timer: Timer?
    var initialCountdownSeconds = 5  // 初期カウントダウン（5秒）
    var mainCountdownSeconds = 61    // 本カウントダウン（60秒）
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = "5"
        startInitialCountdown()
        countLabel.layer.cornerRadius = 100
        countLabel.clipsToBounds = true
        goBackHomeButton.layer.cornerRadius = 20
    }
    

    @IBAction func goBackHomeButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "BackHomeViewController") as? BackHomeViewController else {
            return
        }

        // 0.5秒後に画面遷移を実行
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.view.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view.window?.rootViewController = nextViewController
            }, completion: nil)
        }
    }
    
    func startInitialCountdown() {
        // 初期カウントダウン用のタイマーを設定
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateInitialCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateInitialCountdown() {
        if initialCountdownSeconds > 0 {
            countLabel.text = "\(initialCountdownSeconds)"
            initialCountdownSeconds -= 1
        } else {
            timer?.invalidate()
            startMainCountdown()  // 本カウントダウンを開始
        }
    }

    func startMainCountdown() {
        // 本カウントダウン用のタイマーを設定
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateMainCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateMainCountdown() {
        if mainCountdownSeconds > 0 {
            mainCountdownSeconds -= 1
            countLabel.text = "\(mainCountdownSeconds)"
        } else {
            timer?.invalidate()
            // カウントダウンが終了したときの処理をここに書く
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

        }
    }
}
