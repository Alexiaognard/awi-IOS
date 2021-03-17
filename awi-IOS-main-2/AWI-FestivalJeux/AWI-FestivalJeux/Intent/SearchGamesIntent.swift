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
    
    init(gameList: GameList) {
        self.gameList = gameList
    }
    
    func loadGames(){
        self.gameList.gameListState = .loading
        //Faire appel à l'API
        APIRetriever.loadGamesFromAPI(endofrequest: gamesLoaded)
    }
    
    func gamesLoaded(result: Result<[Game], HttpRequestError>){
        self.gameList.gameListState = .loaded
    }
}
