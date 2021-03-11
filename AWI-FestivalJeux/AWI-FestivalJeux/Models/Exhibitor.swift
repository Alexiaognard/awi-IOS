//
//  Exhibitor.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation

class Exhibitor : Identifiable, Codable {
    var exhibitorId : Int
    var exhibitorEditor : Editor
    var exhibitorName : String
    var exhibitorLocalisation : [Zone]
    
    
    init(id: Int, name:String, exhibitorEditor : Editor, exhibitorLocalisation : [Zone]){
        self.exhibitorId = id
        self.exhibitorName = name
        self.exhibitorEditor = exhibitorEditor
        self.exhibitorLocalisation = exhibitorLocalisation
    }
}
