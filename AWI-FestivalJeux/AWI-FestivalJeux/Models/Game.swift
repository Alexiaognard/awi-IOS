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
    var gameMinimumPlayers : Int
    var gameMaximumPlayers : Int
    var gameType : String
    var gameEditor : Editor
    
    init(id: Int, name:String, gameMinimumAge: Int, gameMinimumPlayers: Int, gameMaximumPlayers : Int, gameType: String, gameEditor: Editor){
        self.gameId = id
        self.gameName = name
        self.gameMinimumAge = gameMinimumAge
        self.gameMinimumPlayers = gameMinimumPlayers
        self.gameMaximumPlayers = gameMaximumPlayers
        self.gameType = gameType
        self.gameEditor = gameEditor
    }
}

struct GameList : Codable {
    var games : [Game]
}
