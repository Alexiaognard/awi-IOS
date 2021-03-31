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

enum EditorState : CustomStringConvertible {
    case waiting
    case loading
    case loaded([Game])
    case loadingError(Error)
    case over
    
    
    var description: String {
        switch self{
        case .waiting: return "waiting"
        case .loading: return "loading"
        case let .loaded(games): return "\(games.count) games loaded"
        case let .loadingError(error): return "loading error : \(error)"
        case .over: return "over"
        }
    }
}

class EditorGameList : Editor, ObservableObject {
    @Published var gameList : [Game]
    
    @Published var editorState : EditorState = .waiting {
        didSet{
            switch self.editorState{
            case let .loaded(games):
                self.new(games)
            default: return
            }
        }
    }
    init(id: String, name: String, gameList: [Game]){
        self.gameList = gameList
        super.init(id: id, name: name)
    }
    
    func new(_ games: [Game]){
        self.gameList = games
        self.editorState = .over
    }
}
