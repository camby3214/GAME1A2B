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
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatAnswerArray()
        setMainTableView()
        setBtnTag()
    }
    
    
    private func creatAnswerArray() {
        var numberSet: Set<Int> = []
        while numberSet.count < 4 {
            let randomNumber = Int.random(in: 0...9)
            numberSet.insert(randomNumber)
        }
        viewModel.answerArray = Array(numberSet)
    }
    
    
    private func setBtnTag() {
        btn0.tag = GameNumBtnTag.Btn0
        btn1.tag = GameNumBtnTag.Btn1
        btn2.tag = GameNumBtnTag.Btn2
        btn3.tag = GameNumBtnTag.Btn3
        btn4.tag = GameNumBtnTag.Btn4
        btn5.tag = GameNumBtnTag.Btn5
        btn6.tag = GameNumBtnTag.Btn6
        btn7.tag = GameNumBtnTag.Btn7
        btn8.tag = GameNumBtnTag.Btn8
        btn9.tag = GameNumBtnTag.Btn9
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
            case GameEnterLabel.EnterLabel1:
                cell.enterLabel1.text = btnNumber
                
            case GameEnterLabel.EnterLabel2:
                cell.enterLabel2.text = btnNumber
                
            case GameEnterLabel.EnterLabel3:
                cell.enterLabel3.text = btnNumber
                
            case GameEnterLabel.EnterLabel4:
                cell.enterLabel4.text = btnNumber
                
            default:
                break
            }
        }
        
        
        if viewModel.currentFocusIndex < GameCurrentState.GameAnswerNumberOfDigits && btnNumber != "" {
            viewModel.currentFocusIndex = viewModel.currentFocusIndex + 1
        }
        
    }
    
    private func btnAction(btnNum: Int){
        if viewModel.enterNumberArray.contains(btnNum) {
            
        } else {
            if viewModel.enterNumberArray.count < GameCurrentState.GameAnswerNumberOfDigits {
                viewModel.enterNumberArray.append(btnNum)
            }
            setLabelText(btnNumber: String(btnNum), labelNumber: viewModel.currentFocusIndex)
        }
        
    }
    
    
    private func compareArray() -> (aValue: Int, bValue: Int){
        var aValue = 0
        var bValue = 0
        
        for (index, value) in viewModel.answerArray.enumerated() {
            if value == viewModel.enterNumberArray[index] {
                aValue += 1
                bValue -= 1
            } else if (viewModel.enterNumberArray.contains(value)) {
                bValue += 1
            }
            
        }
        
        return(aValue: aValue, bValue: bValue)
    }
    
    
    

    
    
    @IBAction func onPressNumBtn(_ sender: UIButton) {
        if viewModel.currentFocusIndex < GameCurrentState.GameAnswerNumberOfDigits {
            btnAction(btnNum: sender.tag)
        }
    }
    
    
    
    
    @IBAction func onPressBtn(_ sender: UIButton) {
        
        switch sender {
        
        case okBtn:
            if viewModel.currentFocusIndex != GameCurrentState.GameAnswerNumberOfDigits {
                break
            }
            
            
            if let cell = mainTableView.cellForRow(at: viewModel.indexPath) as? MainTableViewCell {
                cell.hintLabel1.text = String(compareArray().aValue)
                cell.hintLabel3.text = String(compareArray().bValue)
            }
            viewModel.indexPath.row = viewModel.indexPath.row + 1
            viewModel.currentFocusIndex = 0
            viewModel.enterNumberArray = []
            break
        case CancelBtn:
            if viewModel.currentFocusIndex > 0 {
                viewModel.currentFocusIndex -= 1
                setLabelText(btnNumber: "", labelNumber: viewModel.currentFocusIndex)
                viewModel.enterNumberArray.removeLast()
            }
            break
        default:
            break
        }
        
        
        
    }

}


extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gameNumberOfTime
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        return cell
    }
    
}
