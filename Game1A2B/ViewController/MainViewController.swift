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
        setNav()
    }
    
    func setUI() {
        startBtn.layer.cornerRadius = 12
    }
    
    private func setNav() {
        
        let barButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = barButtonItem
        navigationItem.backBarButtonItem?.tintColor = .black
        let barAppearance = UINavigationBarAppearance()
        
        let titleFont = UIFont.boldSystemFont(ofSize: 30.0) // 設定粗體字型
        let attributes: [NSAttributedString.Key: Any] = [.font: titleFont]
        barAppearance.titleTextAttributes = attributes
        barAppearance.backgroundColor = UIColor(cgColor: CGColor(red: 241/255, green: 224/255, blue: 255/255, alpha: 1))
        navigationController?.navigationBar.standardAppearance = barAppearance
    }

    @IBAction func onPressBtn(_ sender: UIButton) {
        let vc = AssetsManager().getViewController(fromMain:"GameViewController")
        
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
}

