//
//  SignupViewController.swift
//  ProjectB
//
//  Created by 이숭인 on 2021/08/13.
//

import UIKit

protocol SignupViewControllerDelegate {
    var isTextViewShouldEdit: Bool { get set }
    func isButtonEnable() -> Bool
}

class SignupViewController: UIViewController {
    
    @IBOutlet var profileImageView: UIImageView! {
        didSet{
            profileImageView.layer.cornerRadius = 10
            profileImageView.backgroundColor = .lightGray
        }
    }
    @IBOutlet var idTextField: UITextField! {
        didSet{
            idTextField.placeholder = "ID"
            idTextField.delegate = self
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet{
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
            passwordTextField.delegate = self
        }
    }
    @IBOutlet var passwordCheckTextField: UITextField! {
        didSet{
            passwordCheckTextField.placeholder = "Check Password"
            passwordCheckTextField.isSecureTextEntry = true
            passwordCheckTextField.delegate = self
        }
    }
    @IBOutlet var introduceTextView: UITextView! {
        didSet{
            introduceTextView.delegate = self
            introduceTextView.layer.cornerRadius = 10
            introduceTextView.textColor = .gray
            introduceTextView.text = "자기 소개를 부탁드릴게요 !"
            
        }
    }
    
    @IBOutlet var nextButton: UIButton! {
        didSet{
            nextButton.isEnabled = false
        }
    }
    
    lazy var imagePicker: UIImagePickerController = {
       let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        return imagePicker
    }()
    
    let userInfomation: UserInfomation = UserInfomation.shared
    var isFirstEditingTextView: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    @IBAction func moveToAlbum(_ sender: UIButton){
        self.imagePicker.modalPresentationStyle = .fullScreen
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tapView(_ sender: UIGestureRecognizer){
        self.idTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordCheckTextField.resignFirstResponder()
        self.introduceTextView.resignFirstResponder()
    }
    
    @IBAction func cancelSignup(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextSignup(_ sender: UIButton){
        // 다음 화면으로 전환되는 시점에 입력한 정보들 singleton 에 저장
        guard let id = idTextField.text else {
            print("id 빔")
            return
        }
        guard let password = passwordTextField.text else {
            print("password 빔")
            return
        }
        guard let profile = profileImageView.image else {
            print("image 빔")
            return
        }
        guard let introduce = introduceTextView.text else {
            print("intro 빔")
            return
        }
        userInfomation.registUserId(id: id)
        userInfomation.registUserPassword(password: password)
        userInfomation.registUserProfile(profile: profile)
        userInfomation.registUserIntroduce(introduce: introduce)
    }
}

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = editedImage
        }else if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
        
        if isButtonEnable(){
            nextButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 필드 뿐만 아니라 모든 정보가 입력되야 넘어가게끔 nil 체크 해보자
        if isButtonEnable(){
            nextButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
    }
}

extension SignupViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if isTextViewShouldEdit{
            textView.textColor = .black
            textView.text = ""
            isTextViewShouldEdit = false
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        if isButtonEnable(){
            nextButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
    }
}

extension SignupViewController: SignupViewControllerDelegate{
    // textView 의 placeHolder 를 지우고 입력 모드로 전환시에 사용
    var isTextViewShouldEdit: Bool {
        get {
            return isFirstEditingTextView
        }
        set {
            isFirstEditingTextView = newValue
        }
    }
    // 입력란이 모두 유효한지 체크 func
    func isButtonEnable() -> Bool {
        if idTextField.text != "" && profileImageView.image != nil && introduceTextView.text != "" && introduceTextView.text != "자기 소개를 부탁드릴게요 !"{
            if passwordTextField.text == passwordCheckTextField.text && passwordTextField.text != ""  {
                return true
            }
            return false
        }
        return false
    }
}
