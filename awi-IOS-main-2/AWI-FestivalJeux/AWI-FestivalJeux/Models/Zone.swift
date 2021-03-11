//
//  Zone.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation

class Zone : Identifiable, Codable {
    var id = UUID()
    var name : String
    
    
    init(name:String){
        self.name = name
    }
}
