//
//  Editor.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation


class Editor : Identifiable {
    var editorId : String
    var editorName : String
    
    init(id: String, name:String){
        self.editorId = id
        self.editorName = name
    }
}

class EditorGameList : Editor {
    var gameList : [Game]
    init(id: String, name: String, gameList: [Game]){
        self.gameList = gameList
        super.init(id: id, name: name)
    }
}
