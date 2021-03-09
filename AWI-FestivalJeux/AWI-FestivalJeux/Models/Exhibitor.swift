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
    var exhibitorPhone : Int
    var exhibitorMail : String
    var exhibitorGameList : [Game]
    var exhibitorLocalisation : [Zone]
    
    
    init(id: Int, name:String, exhibitorEditor : Editor, exhibitorPhone : Int, exhibitorMail : String, exhibitorGameList : [Game], exhibitorLocalisation : [Zone]){
        self.exhibitorId = id
        self.exhibitorName = name
        self.exhibitorEditor = exhibitorEditor
        self.exhibitorPhone = exhibitorPhone
        self.exhibitorMail = exhibitorMail
        self.exhibitorGameList = exhibitorGameList
        self.exhibitorLocalisation = exhibitorLocalisation
    }
}
