//
//  GameViewController.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/1.
//

import UIKit
import Toast_Swift

class GameViewController: UIViewController, CoustomAlertDelegate {
    
    
    
    
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
    
    
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    
    var viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatAnswerArray()
        setMainTableView()
        setBtnTag()
        setBtn()
        setNav()
        self.title = "1A2B"
        self.view.backgroundColor = .MyColor.game1Bg
        CustomAlert.shared.delegate = self
        countLabel.text = "label_RemainingCount".localizedString()+": "+String(viewModel.gameNumberOfPlays)
        countLabel.font = UIFont.boldSystemFont(ofSize: 24)
        answerLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private func setNav() {
        
        let rightButtonItem = UIBarButtonItem(image: UIImage(systemName: "goforward"), style: .done, target: self, action: #selector(addButtonTapped))
        rightButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func addButtonTapped() {
        reload()
        setBtnEnable(enable: true)
    }
    
    private func reload() {
        viewModel = GameViewModel()
        creatAnswerArray()
        viewModel.isReload = 1
        mainTableView.reloadData()
        countLabel.text = "lable_RemainingCount".localizedString()+": "+String(viewModel.gameNumberOfPlays)
        answerLabel.isHidden = true
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
        okBtn.backgroundColor = .MyColor.okBtn
        cancelBtn.backgroundColor = .MyColor.cancelBtn
    }
    
    private func setMainTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = .MyColor.game1Bg
        mainTableView.layer.borderWidth = 3
        mainTableView.layer.borderColor = UIColor.MyColor.lineBoard.cgColor
        mainTableView.layer.cornerRadius = 10
        
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
    
    private func setBtnEnable(enable: Bool) {
        btn0.isEnabled = enable
        btn1.isEnabled = enable
        btn2.isEnabled = enable
        btn3.isEnabled = enable
        btn4.isEnabled = enable
        btn5.isEnabled = enable
        btn6.isEnabled = enable
        btn7.isEnabled = enable
        btn8.isEnabled = enable
        btn9.isEnabled = enable
        okBtn.isEnabled = enable
        cancelBtn.isEnabled = enable
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
            CustomAlert.shared.showAlert(with: "Good Job!", message: "", on: self, backgroundImg: "alert_bg", crossImg: "cross", logoImg: "")
        }
        
        if viewModel.indexPath.row == viewModel.gameNumberOfPlays - 1 {
            var answer = ""
            for num in viewModel.answerArray {
                answer = answer + String(num)
            }
            
            CustomAlert.shared.showAlert(with: "alert_fail_title".localizedString(), message: "alert_fail_body".localizedString()+answer, on: self, backgroundImg: "alert_bg", crossImg: "cross", logoImg: "")
        }
        
        
        return(aValue: aValue, bValue: bValue)
    }
    
    
    func confirmAction() {
        self.reload()
        setBtnEnable(enable: true)
    }

    func crossAction() {
        self.setBtnEnable(enable: false)
        answerLabel.isHidden = false
        var answer = ""
        for num in viewModel.answerArray {
            answer = answer+String(num)
        }
        
        answerLabel.text = "label_answer".localizedString()+answer
    }
    
    @IBAction func onPressNumBtn(_ sender: UIButton) {
        if viewModel.currentFocusIndex < GameCurrentState.GameAnswerNumberOfDigits {
            btnAction(btnNum: sender.tag)
            sender.isEnabled = false
        }
        
    }
    
    
    
    
    @IBAction func onPressBtn(_ sender: UIButton) {
        
        switch sender {
        
        case okBtn:
            if viewModel.currentFocusIndex != GameCurrentState.GameAnswerNumberOfDigits {
                
                self.view.makeToast("Toast_EnterFail".localizedString())
                break
            }
            
            self.countLabel.text = "lable_RemainingCount".localizedString()+": "+String(viewModel.gameNumberOfPlays - viewModel.indexPath.row - 1)
            
            if let cell = mainTableView.cellForRow(at: viewModel.indexPath) as? MainTableViewCell {
                UILabel.setNumLabel(label: cell.hintLabel1, string: String(compareArray().aValue))
                UILabel.setNumLabel(label: cell.hintLabel2, string: "A")
                UILabel.setNumLabel(label: cell.hintLabel3, string: String(compareArray().bValue))
                UILabel.setNumLabel(label: cell.hintLabel4, string: "B")
            }
            viewModel.indexPath.row = viewModel.indexPath.row + 1
            viewModel.currentFocusIndex = 0
            viewModel.enterNumberArray = []
            
            setBtnEnable(enable: true)
            break
        case cancelBtn:
            if viewModel.currentFocusIndex > 0 {
                viewModel.currentFocusIndex -= 1
                setLabelText(btnNumber: "", labelNumber: viewModel.currentFocusIndex)
                
                if let button = self.view.viewWithTag(viewModel.enterNumberArray.last ?? 100) as? UIButton {
                    button.isEnabled = true
                }
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
        return viewModel.gameNumberOfPlays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .MyColor.game1Bg
        if viewModel.isReload == 1 {
            cell.enterLabel1.text = ""
            cell.enterLabel2.text = ""
            cell.enterLabel3.text = ""
            cell.enterLabel4.text = ""
            cell.hintLabel1.text = ""
            cell.hintLabel2.text = ""
            cell.hintLabel3.text = ""
            cell.hintLabel4.text = ""
            
            if indexPath.row == viewModel.gameNumberOfPlays - 1 {
                viewModel.isReload = 0
            }
        }
        
        return cell
    }
    
}
