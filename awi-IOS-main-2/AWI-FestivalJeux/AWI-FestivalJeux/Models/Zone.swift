//
//  Zone.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation

class Zone : Codable {
    var zoneId : Int
    var name : String
    
    
    init(zoneId: Int, name:String){
        self.zoneId = zoneId
        self.name = name
    }
}
