//
//  UserInfo.swift
//  CpNocoloV1.1
//
//  Created by Yousuf Alam on 6/11/21.
//

import Foundation

class userInformation {
    public var FirstName : String
    public var LastName : String
    public var Email : String
    public var Mobile : String
    public var ID : Int
    public var doc : String
    public var codeforcesId : String
    
    init(FirstName : String, LastName : String, Email : String, Mobile : String, ID : Int, doc : String, codeforcesId : String)
    {
        self.FirstName = FirstName
        self.LastName = LastName
        self.Email = Email
        self.Mobile = Mobile
        self.ID = ID
        self.doc = doc
        self.codeforcesId = codeforcesId
        
    }
}

