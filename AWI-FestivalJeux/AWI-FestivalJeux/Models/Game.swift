//
//  Game.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation

class Game : Identifiable, Codable {
    var gameId : Int
    var gameName : String
    var gameMinimumAge : Int
    var gameDuration : Int
    var isPrototype : Bool
    var gameMinimumPlayers : Int
    var gameMaximumPlayers : Int
    var gameType : String
    var gameEditor : Editor
    var gameZone : Zone
    var isAP : Bool
    
    init(id: Int, name:String, gameMinimumAge: Int, gameDuration: Int, isPrototype : Bool, gameMinimumPlayers: Int, gameMaximumPlayers : Int, gameType: String, gameEditor: Editor, gameZone: Zone, isAP: Bool){
        self.gameId = id
        self.gameName = name
        self.gameMinimumAge = gameMinimumAge
        self.gameDuration = gameDuration
        self.isPrototype = isPrototype
        self.gameMinimumPlayers = gameMinimumPlayers
        self.gameMaximumPlayers = gameMaximumPlayers
        self.gameType = gameType
        self.gameEditor = gameEditor
        self.gameZone = gameZone
        self.isAP = isAP
    }
}

struct GameList : Codable {
    var games : [Game]
}
