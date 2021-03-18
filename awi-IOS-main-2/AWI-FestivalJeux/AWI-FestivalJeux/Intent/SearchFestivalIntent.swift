//
//  SearchFestivalIntent.swift
//  AWI-FestivalJeux
//
//  Created by user190796 on 3/18/21.
//

import Foundation

class SearchFestivalIntent {
    var festival : Festival = Festival.festivalSingleton
    
    
    func loadFestival(){
        self.festival.festivalState = .loading
        //Faire appel à l'API
        APIRetriever.loadFestivalFromAPI(endofrequest: festivalLoaded)
    }
    
    func festivalLoaded(result: Result<Int, HttpRequestError>){
        switch result {
        case let .success(data):
            self.festival.festivalState = .loaded
        case let .failure(error):
            self.festival.festivalState = .loadingError(error)
        }
        
    }
}
