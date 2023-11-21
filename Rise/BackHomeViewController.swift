//
//  BackHomeViewController.swift
//  Rise
//
//  Created by Issei Ueda on 2023/11/21.
//

import UIKit

class BackHomeViewController: UIViewController {

    @IBOutlet weak var backHomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backHomeButton(_ sender: Any) {
        UIControl().sendAction(NSSelectorFromString("suspend"), to: UIApplication.shared, for: nil)

    }
}
