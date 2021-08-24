//
//  SignupSecondViewController.swift
//  ProjectB
//
//  Created by 이숭인 on 2021/08/22.
//

import UIKit

// 가입 Enable 하려면
// 1. Picker 값 처음 변경하면 bool true ,
// 2. 전화번호 라벨 값 존재
// 1, 2 둘 다 성립하면 가입 버튼 Enable -> true

protocol SignupSecondViewControllerDelegate{
    var isFirstEditing: Bool { get set } // datePicker 날짜 수정 여부
    func dateToString() -> String // 초기 날짜 값 convert string
    func dateToString(_ sender: UIDatePicker) -> String // 변경된 날짜 값 convert string
    func isButtonEnable() // 설정값이 모두 존재하는지 체크
}

protocol SignupSecondViewControllerDataSource{
    func setPhoneNumberTextField()  // phoneNumber textField 초기화
    func setDatePickerDate()  // datePicker가 가리키고있는거 초기화
    func setDateLabel()  // birth 라벨 초기화
}

class SignupSecondViewController: UIViewController {
    @IBOutlet var phoneNumberTextField: UITextField!{
        didSet{
            phoneNumberTextField.delegate = self
            phoneNumberTextField.keyboardType = .numberPad
        }
    }
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var signupButton: UIButton!{
        didSet{
            signupButton.isEnabled = false
        }
    }
    @IBOutlet var datePicker: UIDatePicker!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    let userInfomation: UserInfomation = UserInfomation.shared
    var isEdit: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhoneNumberTextField()
        setDatePickerDate()
        setDateLabel()
        
    }
    
    @IBAction func valueChangeDatepicker(_ sender: UIDatePicker){
        dateLabel.text = dateToString(sender)
        isFirstEditing = true
        
        isButtonEnable()
    }
    
    
    @IBAction func cancelSignup(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func prevToSignup(_ sender: UIButton){
        guard let phoneNumber = phoneNumberTextField.text else {
            print("phoneNumber 입력 안되어있음")
            return
        }
        guard let birth = dateLabel.text else {
            print("birth 입력 안되어있음")
            return
        }
        
        userInfomation.registUserPhoneNumber(phoneNumber: phoneNumber)
        userInfomation.registUserBirth(birth: birth)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signup(_ sender: UIButton){
        //유저정보 저장하고, 1번화면의 id 입력창에 유저 아이디 넣어놓기
        dismiss(animated: true, completion: nil)
    }
}

extension SignupSecondViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isButtonEnable()
    }
}

extension SignupSecondViewController: SignupSecondViewControllerDelegate{
    var isFirstEditing: Bool {
        get {
            return isEdit
        }
        set {
            isEdit = newValue
        }
    }
    
    func dateToString() -> String {
        let date: Date = datePicker.date
        let dateToString: String = dateFormatter.string(from: date)
        
        return dateToString
    }
    
    func dateToString(_ sender: UIDatePicker) -> String {
        let date: Date = sender.date
        let dateToString: String = dateFormatter.string(from: date)
        
        return dateToString
    }
    
    func isButtonEnable() {
        if isFirstEditing && phoneNumberTextField.text != "" {
            signupButton.isEnabled = true
        }else{
            signupButton.isEnabled = false
        }
    }
}


extension SignupSecondViewController: SignupSecondViewControllerDataSource {
    func setPhoneNumberTextField() {
        phoneNumberTextField.text =  userInfomation.getPhoneNumber()
    }
    
    func setDatePickerDate() {
        if userInfomation.getBirth() != "" {
            let datetime = dateFormatter.date(from: userInfomation.getBirth())
            if let unwrappedDate = datetime{
                datePicker.setDate(unwrappedDate, animated: true)
            }
        }
    }
    
    func setDateLabel() {
        dateLabel.text = dateToString()
    }
    
    
}
