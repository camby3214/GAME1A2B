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
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatAnswerArray()
        setMainTableView()
        setBtnTag()
        setBtn()
        self.title = String(viewModel.answerArray[0]) + String(viewModel.answerArray[1]) + String(viewModel.answerArray[2]) + String(viewModel.answerArray[3])
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 241/255, green: 224/255, blue: 255/255, alpha: 1))
        
    }
    
    private func reload() {
        viewModel = GameViewModel()
        creatAnswerArray()
        viewModel.isReload = 1
        mainTableView.reloadData()
        self.title = String(viewModel.answerArray[0]) + String(viewModel.answerArray[1]) + String(viewModel.answerArray[2]) + String(viewModel.answerArray[3])
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
    private func setBtn() {
        UIButton.setNumberBtn(btn: btn0, title: "0")
        UIButton.setNumberBtn(btn: btn1, title: "1")
        UIButton.setNumberBtn(btn: btn2, title: "2")
        UIButton.setNumberBtn(btn: btn3, title: "3")
        UIButton.setNumberBtn(btn: btn4, title: "4")
        UIButton.setNumberBtn(btn: btn5, title: "5")
        UIButton.setNumberBtn(btn: btn6, title: "6")
        UIButton.setNumberBtn(btn: btn7, title: "7")
        UIButton.setNumberBtn(btn: btn8, title: "8")
        UIButton.setNumberBtn(btn: btn9, title: "9")
        UIButton.setNumberBtn(btn: okBtn, title: "OK")
        UIButton.setNumberBtn(btn: cancelBtn, title: "C")
    }
    
    private func setMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.separatorStyle = .singleLine
        mainTableView.separatorColor = .black
        mainTableView.backgroundColor = UIColor(cgColor: CGColor(red: 241/255, green: 224/255, blue: 255/255, alpha: 1))
        
    }
    
    private func setLabelText(btnNumber: String, labelNumber: Int) {
        
        if let cell = mainTableView.cellForRow(at: viewModel.indexPath) as? MainTableViewCell {
            switch labelNumber {
            case GameEnterLabel.EnterLabel1:
                UILabel.setNumLabel(label: cell.enterLabel1, string: btnNumber)
                
            case GameEnterLabel.EnterLabel2:
                UILabel.setNumLabel(label: cell.enterLabel2, string: btnNumber)
                
            case GameEnterLabel.EnterLabel3:
                UILabel.setNumLabel(label: cell.enterLabel3, string: btnNumber)
                
            case GameEnterLabel.EnterLabel4:
                UILabel.setNumLabel(label: cell.enterLabel4, string: btnNumber)
                
            default:
                break
            }
        }
        
        
        if viewModel.currentFocusIndex < GameCurrentState.GameAnswerNumberOfDigits && btnNumber != "" {
            viewModel.currentFocusIndex = viewModel.currentFocusIndex + 1
        }
        
    }
    
    private func btnDisable() {
        btn0.isEnabled = false
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
        btn5.isEnabled = false
        btn6.isEnabled = false
        btn7.isEnabled = false
        btn8.isEnabled = false
        btn9.isEnabled = false
        okBtn.isEnabled = false
        cancelBtn.isEnabled = false
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
            } else if (viewModel.enterNumberArray.contains(value)) {
                bValue += 1
            }
            
        }
        if aValue == 4 {
            let alert = UIAlertController(title: "成功", message: "恭喜答對", preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default){ (_) in
                self.btnDisable()
            }
            let action2 = UIAlertAction(title: "重來", style: .default){ (_) in
                self.reload()
            }
            
            alert.addAction(action)
            alert.addAction(action2)
            present(alert, animated: true)
        }
        
        if viewModel.indexPath.row == viewModel.gameNumberOfTime - 1 {
            let alert = UIAlertController(title: "失敗", message: "超過次數", preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default){ (_) in
                self.btnDisable()
            }
            let action2 = UIAlertAction(title: "重來", style: .default){ (_) in
                self.reload()
            }
            
            alert.addAction(action)
            alert.addAction(action2)
            present(alert, animated: true)
        
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
                UILabel.setNumLabel(label: cell.hintLabel1, string: String(compareArray().aValue))
                UILabel.setNumLabel(label: cell.hintLabel2, string: "A")
                UILabel.setNumLabel(label: cell.hintLabel3, string: String(compareArray().bValue))
                UILabel.setNumLabel(label: cell.hintLabel4, string: "B")
            }
            viewModel.indexPath.row = viewModel.indexPath.row + 1
            viewModel.currentFocusIndex = 0
            viewModel.enterNumberArray = []
            break
        case cancelBtn:
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
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(cgColor: CGColor(red: 241/255, green: 224/255, blue: 255/255, alpha: 1))
        if viewModel.isReload == 1 {
            cell.enterLabel1.text = ""
            cell.enterLabel2.text = ""
            cell.enterLabel3.text = ""
            cell.enterLabel4.text = ""
            cell.hintLabel1.text = ""
            cell.hintLabel2.text = ""
            cell.hintLabel3.text = ""
            cell.hintLabel4.text = ""
            
            if indexPath.row == viewModel.gameNumberOfTime - 1 {
                viewModel.isReload = 0
            }
        }
        
        return cell
    }
    
}
