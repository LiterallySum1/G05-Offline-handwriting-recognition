//
//  MainViewController.swift
//  Coding_Final
//
//  Created by Ethan Muller on 16/1/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var SkipBtn: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func TutorialShown(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Onboard")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
}
