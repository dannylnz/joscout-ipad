//
//  Player.swift
//  joscout ipad
//
//  Created by Daniele Lanzetta on 09.11.17.
//  Copyright © 2017 Daniele Lanzetta. All rights reserved.
//

import Foundation

class PlayerClass: NSObject {
    var name:String?
    var age:Int?
    var height:Int?
    var nationality:String?
    var position:String?
    
    let newPlayer = [[String:Any]]()
    
    
    
    
    init(name: String?, age: Int?, height: Int?, nationality: String?, position: String?) {
        
        self.name = name
        self.age = age
        self.height = height
        self.nationality = nationality
        self.position = position
        
    }
    
}
