//
//  GameList.swift
//  AWI-FestivalJeux
//
//  Created by etud on 11/03/2021.
//

import Foundation
import SwiftUI
import Combine

enum GameListState: CustomStringConvertible{
    case loaded
    case loading
    case waiting
    
    var description: String{
        switch self{
        case .loaded : return "loaded"
        case .loading : return "loading"
        case .waiting : return "waiting"
        }
    }
}

class GameList: ObservableObject{
    @Published var gameListState: GameListState = .waiting{
        didSet{
            switch self.gameListState {
            default :
                return
            }
        }
    }
    
    @Published var gameList = [Game]()
}
