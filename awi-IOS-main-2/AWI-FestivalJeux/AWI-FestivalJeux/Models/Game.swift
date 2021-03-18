//
//  Game.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation

class Game : Identifiable {
    private(set) var gameId : Int
    private(set) var gameName : String
    private(set) var gameMinimumAge : Int
    private(set) var gameDuration : Int?
    private(set) var isPrototype : Bool
    private(set) var gameMinimumPlayers : Int
    private(set) var gameMaximumPlayers : Int
    private(set) var gameType : String
    private(set) var gameEditor : Editor
    private(set) var gameZone : Zone
    private(set) var isAP : Bool
    private(set) var notice : String
    
    init(id: Int, name:String, gameMinimumAge: Int, gameDuration: Int?, isPrototype : Bool, gameMinimumPlayers: Int, gameMaximumPlayers : Int, gameType: String, gameEditor: Editor, gameZone: Zone, isAP: Bool, notice: String){
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
        self.notice = notice
    }
    /*
    enum CodingKeys: String, CodingKey{
        case gameId
        case gameName = "gameName"
        case gameMinimumAge
        case gameDuration
        case isPrototype
        case gameMinimumPlayers
        case gameMaximumPlayers
        case gameType
        case gameEditor
        case gameZone
        case isAP
        case notice
    }*/
}
