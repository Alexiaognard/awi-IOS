//
//  SearchGamesIntent.swift
//  AWI-FestivalJeux
//
//  Created by etud on 11/03/2021.
//

import Foundation
import SwiftUI

class SearchGamesIntent : IntentFilter {
    @ObservedObject var gameList : GameList
    @ObservedObject var festival : Festival
    
    init(gameList: GameList, festival: Festival) {
        self.gameList = gameList
        self.festival = festival
    }
    
    func loadGames(){
        self.gameList.gameListState = .loading
        
        //Faire appel à l'API
        APIRetriever.loadGamesFromAPI(endofrequest: gamesLoaded, festivalId: festival.festivalId)
    }
    
    func gamesLoaded(result: Result<[Game], HttpRequestError>){
        switch result {
        case let .success(data):
            print(data.description)
            self.gameList.gameListState = .loaded(data)
        case let .failure(error):
            self.gameList.gameListState = .loadingError(error)
        }
        
    }
    
    func filter(filterOption: String) -> Void{
        return
    }
}
