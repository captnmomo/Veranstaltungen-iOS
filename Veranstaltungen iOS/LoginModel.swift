//
//  LoginModel.swift
//  Veranstaltungen iOS
//
//  Created by momo on 06.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class LoginModel: NSObject {
    
    var uname: String?
    var userrole: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(uname: String, userrole: String) {
        
        self.uname = uname
        self.userrole = userrole
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "User: \(uname), Userrole: \(userrole)"
        
    }

}
