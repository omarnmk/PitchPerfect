//
//  UserDefaults+Constants.swift
//  PitchPerfect
//
//  Created by Omar Namnakani on 15/01/2019.
//  Copyright © 2019 OmarNmk. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults{
    
    func setThemeStyle(_ value: ThemeStyle){
        UserDefaults.standard.set(value.rawValue, forKey: "ThemeStyle")
    }
    
    func currentThemeStyle() -> ThemeStyle{
        
        if let savedStyle = UserDefaults.standard.string(forKey: "ThemeStyle"), let themeStyle = ThemeStyle(rawValue: savedStyle){
            return themeStyle
        }
        
        //Return default if user has not set any. 
        return .light
    }
    
}


