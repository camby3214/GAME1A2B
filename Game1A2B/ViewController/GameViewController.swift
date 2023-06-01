//
//  GameViewController.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/1.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
           cell.enterLabel1.text = ""
        return cell
    }
    
    
    @IBOutlet weak var btn: UIButton!
   
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var indexPath = IndexPath(row: 0, section: 0)
    var count = 0
    var array: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.separatorStyle = .singleLine
        mainTableView.separatorColor = .black
        
    }
    
    func setLabelText(btnNumber: String, labelNumber: Int) {
        if let cell = mainTableView.cellForRow(at: indexPath) as? MainTableViewCell {
            switch labelNumber {
            case 0:
                cell.enterLabel1.text = btnNumber
            case 1:
                cell.enterLabel2.text = btnNumber
            case 2:
                cell.enterLabel3.text = btnNumber
            case 3:
                cell.enterLabel4.text = btnNumber
            default:
                break
            }
        }
        if count<3 {
            count = count + 1
        }
        
    }
    
    
    

    @IBAction func onpress(_ sender: UIButton) {
        
        switch sender {
        case btn:
            if count < 4 {
                // 判斷是否重複
                array.append(9)
                setLabelText(btnNumber: "9", labelNumber: count)
            }
            
            break
        case okBtn:
            if count != 3 {
                break
            }
            
            
            if let cell = mainTableView.cellForRow(at: indexPath) as? MainTableViewCell {
                cell.hintLabel1.text = "1"
                cell.hintLabel3.text = "2"
            }
            indexPath.row = indexPath.row+1
            count = 0
        default:
            break
        }
        
        
        
    }

}
