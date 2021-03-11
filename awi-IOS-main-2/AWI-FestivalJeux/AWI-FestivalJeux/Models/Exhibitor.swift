//
//  Exhibitor.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation

class Exhibitor : Identifiable, Codable {
    var exhibitorId : Int
    var exhibitorName : String
    var exhibitorLocalisation : [Zone]
    
    
    init(id: Int, name:String, exhibitorLocalisation : [Zone]){
        self.exhibitorId = id
        self.exhibitorName = name
        self.exhibitorLocalisation = exhibitorLocalisation
    }
}
