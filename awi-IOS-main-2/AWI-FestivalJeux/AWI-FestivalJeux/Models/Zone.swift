//
//  Zone.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation

class Zone : Identifiable {
    var zoneId : String
    var name : String
    
    
    init(zoneId: String, name:String){
        self.zoneId = zoneId
        self.name = name
    }
}
