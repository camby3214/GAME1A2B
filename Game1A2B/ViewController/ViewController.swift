//
//  ViewController.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/1.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        startBtn.layer.cornerRadius = 12
    }
    

    @IBAction func onPressBtn(_ sender: UIButton) {
        let vc = AssetsManager().getViewController(fromMain:"GameViewController")
        
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
}

