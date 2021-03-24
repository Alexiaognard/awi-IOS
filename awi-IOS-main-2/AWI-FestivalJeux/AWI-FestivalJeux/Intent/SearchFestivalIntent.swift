//
//  SearchFestivalIntent.swift
//  AWI-FestivalJeux
//
//  Created by user190796 on 3/18/21.
//

import Foundation
import SwiftUI
import Combine

class SearchFestivalIntent {
    @ObservedObject var festival : Festival
    
    init(festival: Festival){
        self.festival = festival
    }
    
    func loadFestival(){
        switch festival.festivalState {
        case .waiting:
            self.festival.festivalState = .loading
            //Faire appel à l'API
            APIRetriever.loadFestivalFromAPI(endofrequest: festivalJsonLoaded)
        default: return
        }
    }
    
    func festivalJsonLoaded(result: Result<Festival, HttpRequestError>){
        switch result {
        case let .success(data):
            self.festival.festivalState = .loaded(data)
        case let .failure(error):
            self.festival.festivalState = .loadingError(error)
        }
    }
    
    func festivalLoaded(){
        self.festival.festivalState = .over
    
        
    }
}
