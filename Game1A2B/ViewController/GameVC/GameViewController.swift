//
//  GameViewController.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/1.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn6: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn0: UIButton!
    
    
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainTableView()
        setBtnTag()
    }
    
    
    private func setBtnTag() {
        btn0.tag = 0
        btn1.tag = 1
        btn2.tag = 2
        btn3.tag = 3
        btn4.tag = 4
        btn5.tag = 5
        btn6.tag = 6
        btn7.tag = 7
        btn8.tag = 8
        btn9.tag = 9
    }
    
    private func setMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.separatorStyle = .singleLine
        mainTableView.separatorColor = .black
    }
    
    private func setLabelText(btnNumber: String, labelNumber: Int) {
        if let cell = mainTableView.cellForRow(at: viewModel.indexPath) as? MainTableViewCell {
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
        if viewModel.currentFocusIndex<3 {
            viewModel.currentFocusIndex = viewModel.currentFocusIndex + 1
        }
        
    }
    
    private func btnAction(btnNum: Int){
        if viewModel.enterNumberArray.contains(btnNum) {
            
        } else {
            viewModel.enterNumberArray.append(btnNum)
            setLabelText(btnNumber: String(btnNum), labelNumber: viewModel.currentFocusIndex)
        }
        
    }
    

    
    
    @IBAction func onPressNumBtn(_ sender: UIButton) {
        if viewModel.currentFocusIndex < 4 {
            btnAction(btnNum: sender.tag)
        }
    }
    
    
    
    
    @IBAction func onpress(_ sender: UIButton) {
        
        switch sender {
        
        case okBtn:
            if viewModel.currentFocusIndex != 3 {
                break
            }
            
            
            if let cell = mainTableView.cellForRow(at: viewModel.indexPath) as? MainTableViewCell {
                cell.hintLabel1.text = "1"
                cell.hintLabel3.text = "2"
            }
            viewModel.indexPath.row = viewModel.indexPath.row+1
            viewModel.currentFocusIndex = 0
            viewModel.enterNumberArray = []
        default:
            break
        }
        
        
        
    }

}


extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
           cell.enterLabel1.text = ""
        return cell
    }
    
}
