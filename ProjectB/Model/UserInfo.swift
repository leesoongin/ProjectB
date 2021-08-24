//
//  ads.swift
//  ProjectB
//
//  Created by 이숭인 on 2021/08/22.
//

import UIKit

struct UserInfo {
    private var id: String
    private var password: String
    private var introduce: String
    private var profile: UIImage?
    private var phoneNumber: String
    private var birth: String
    
    init(id: String, password: String, introduce: String, profile: UIImage?, phoneNumber: String, birth: String){
        self.id = id
        self.password = password
        self.introduce = introduce
        self.profile = profile
        self.phoneNumber = phoneNumber
        self.birth = birth
    }
    
    mutating func setId(_ id: String){
        self.id = id
    }
    mutating func setPassword(_ password: String){
        self.password = password
    }
    mutating func setIntroduce(_ introduce: String){
        self.introduce = introduce
    }
    mutating func setProfile(_ profile: UIImage?){
        self.profile = profile
    }
    mutating func setPhoneNumber(_ phoneNumber: String){
        self.phoneNumber = phoneNumber
    }
    mutating func setBirth(_ birth: String){
        self.birth = birth
    }
    
    func getId() -> String{
        return self.id
    }
    func getPassword() -> String{
        return self.password
    }
    func getIntroduce() -> String{
        return self.introduce
    }
    func getProfile() -> UIImage?{
        return self.profile
    }
    func getPhoneNumber() -> String{
        return phoneNumber
    }
    func getBirth() -> String{
        return birth
    }
}
