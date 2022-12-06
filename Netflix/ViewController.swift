//
//  ViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 05/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(switchToMainTabbar), userInfo: nil, repeats: false)
    }
    
    @objc func switchToMainTabbar(){
        let storyboard = UIStoryboard(name: "MainTabbar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as UIViewController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }


}

