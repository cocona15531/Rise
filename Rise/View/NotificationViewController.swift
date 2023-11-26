//
//  NotificationViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 通知の許可をリクエスト
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("通知の許可リクエストに失敗しました: \(error.localizedDescription)")
            }
        }
        datePicker.datePickerMode = .time
        settingButton.layer.cornerRadius = 20
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }

    @IBAction func datePickerChanged(_ sender: Any) {
        guard let datePicker = sender as? UIDatePicker else { return }
        let selectedTime = datePicker.date
        updateTimerLabel(with: selectedTime)
    }
    
    @IBAction func settingButtonTapped(_ sender: Any) {
        scheduleNotification(at: datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateTimerLabel(with time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        timerLabel.text = dateFormatter.string(from: time)
    }

    private func scheduleNotification(at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Rise"
        content.body = "1日を始めましょう"
        content.sound = UNNotificationSound.default

        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let combinedComponents = DateComponents(year: todayComponents.year, month: todayComponents.month, day: todayComponents.day, hour: timeComponents.hour, minute: timeComponents.minute)

        let trigger = UNCalendarNotificationTrigger(dateMatching: combinedComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知のスケジュールに失敗しました: \(error.localizedDescription)")
            }
        }
    }
}
