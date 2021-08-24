//
//  UserInfomation.swift
//  ProjectB
//
//  Created by 이숭인 on 2021/08/22.
//

import UIKit

class UserInfomation{
    static let shared = UserInfomation()
    
    private init(){}
    var userInfo: UserInfo = UserInfo(id: "",
                                      password: "",
                                      introduce: "",
                                      profile: nil,
                                      phoneNumber: "",
                                      birth: ""
    )
    
    func registUserId(id: String){
        userInfo.setId(id)
    }
    
    func registUserPassword(password: String){
        userInfo.setPassword(password)
    }
    
    func registUserProfile(profile: UIImage?){
        userInfo.setProfile(profile)
    }
    
    func registUserIntroduce(introduce: String){
        userInfo.setIntroduce(introduce)
    }
    
    func registUserPhoneNumber(phoneNumber: String){
        userInfo.setPhoneNumber(phoneNumber)
    }
    
    func registUserBirth(birth: String){
        userInfo.setBirth(birth)
    }
    
    func getUserId() -> String {
        return userInfo.getId()
    }
    
    func getPhoneNumber() -> String{
        return userInfo.getPhoneNumber()
    }
    
    func getBirth() -> String{
        return userInfo.getBirth()
    }
}
