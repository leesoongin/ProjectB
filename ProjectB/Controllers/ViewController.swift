//
//  ViewController.swift
//  ProjectB
//
//  Created by 이숭인 on 2021/08/12.
//

import UIKit

class ViewController: UIViewController  {

    @IBOutlet var logoImageView: UIImageView! {
        didSet{
            logoImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet var idTextField: UITextField! {
        didSet{
            idTextField.delegate = self
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet{
            passwordTextField.delegate = self
        }
    }
    @IBOutlet var bottomContainerMargin: NSLayoutConstraint!
    @IBOutlet var containerView: UIView!
    
    private var originalBottomMargin: CGFloat = 0
    let userInfomation: UserInfomation = UserInfomation.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        
        // bottom constraint setting
        originalBottomMargin = self.bottomContainerMargin.constant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if userInfomation.getUserId() != "" {
            idTextField.text = userInfomation.getUserId()
        }
    }
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            
            UIView.animate(withDuration: animationDuration) {
                self.bottomContainerMargin.constant = keyboardHeight - self.view.safeAreaInsets.bottom
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.bottomContainerMargin.constant = self.originalBottomMargin
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @IBAction func moveToSignUp(_ sender: UIButton){
        //TODO: 화면전환
        print("asdasd")
    }
    
}

extension ViewController: UIGestureRecognizerDelegate{
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        self.view.resignFirstResponder()
//        return true
//    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
