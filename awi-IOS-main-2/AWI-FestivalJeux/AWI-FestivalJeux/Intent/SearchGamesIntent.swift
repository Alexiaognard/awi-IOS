//
//  SearchGamesIntent.swift
//  AWI-FestivalJeux
//
//  Created by etud on 11/03/2021.
//

import Foundation
import SwiftUI

class SearchGamesIntent {
    @ObservedObject var gameList : GameList
    @ObservedObject var festival : Festival
    
    init(gameList: GameList, festival: Festival) {
        self.gameList = gameList
        self.festival = festival
    }
    
    func loadGames(){
        switch gameList.gameListState {
        case .waiting:
            self.gameList.gameListState = .loading
            //Faire appel à l'API
            APIRetriever.loadGamesFromAPI(endofrequest: gamesJsonLoaded, festivalId: festival.festivalId)
        default: return
        }
    }
    
    func refreshGames(){
        switch self.gameList.gameListState{
        case .over:
            self.gameList.gameListState = .loading
            //Faire appel à l'API
            APIRetriever.loadGamesFromAPI(endofrequest: gamesJsonLoaded, festivalId: festival.festivalId)
            default: return
        }
        
    }
    
    func gamesJsonLoaded(result: Result<[Game], HttpRequestError>){
        switch result {
        case let .success(data):
            self.gameList.gameListState = .loaded(data)
        case let .failure(error):
            self.gameList.gameListState = .loadingError(error)
        }
        
    }
    
    func gamesLoaded(){
        self.gameList.gameListState = .over
    }
}
