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
    case over
    case loaded([Game])
    case loadingError(Error)
    case loading
    case waiting
    
    var description: String{
        switch self{
        case .over : return "over"
        case .loaded(let games) : return "loaded : \(games.count) games"
        case .loadingError(let error) : return "loading error : \(error)"
        case .loading : return "loading"
        case .waiting : return "waiting"
        }
    }
}

class GameList: ObservableObject{
    @Published var gameListState: GameListState = .waiting{
        didSet{
            switch self.gameListState {
            case let .loaded(data):
                self.new(games: data)
            case let .loadingError(error):
                print(error)
                //Si une erreur pendant le chargement des jeux
                return
            default :
                return
            }
        }
    }
    
    @Published var gameList = [Game]()
    
    func new(games: [Game]){
        self.gameList = games
        self.gameListState = .waiting
    }
    
}
