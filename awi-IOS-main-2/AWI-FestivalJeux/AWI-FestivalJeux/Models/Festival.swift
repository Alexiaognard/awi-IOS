//
//  Festival.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import Foundation

class Festival: Codable {
    static var isSet = false
    
    var _festivalId : Int
    var name : String
    var date : Date
    
    private init(name:String, date: Date){
        self.name = name
        self.date = date
        Festival.isSet = true
    }
}
