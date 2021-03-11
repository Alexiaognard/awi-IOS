//
//  Festival.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import Foundation

class Festival: Identifiable, Codable {
    var id = UUID()
    var name : String
    var date : Date
    
    init(name:String, date: Date){
        self.name = name
        self.date = date
    }
}
