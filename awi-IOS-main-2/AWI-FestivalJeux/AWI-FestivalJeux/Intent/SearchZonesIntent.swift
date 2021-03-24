//
//  SearchZonesIntent.swift
//  AWI-FestivalJeux
//
//  Created by etud on 12/03/2021.
//

import Foundation
import SwiftUI

class SearchZonesIntent {
    @ObservedObject var zoneList : ZoneList
    @ObservedObject var festival : Festival
    
    init(zoneList: ZoneList, festival: Festival) {
        self.zoneList = zoneList
        self.festival = festival
    }
    
    func loadZones(){
        self.zoneList.zoneListState = .loading
        //Faire appel à l'API
        APIRetriever.loadZonesFromAPI(endofrequest: zonesLoaded, festivalId: festival.festivalId)
    }
    
    func zonesLoaded(results: Result<[Zone],HttpRequestError>){
        switch results{
        case let .success(data):
            self.zoneList.zoneListState = .loaded(data)
        case let .failure(error):
            self.zoneList.zoneListState = .loadingError(error)
        }
        
    }
}
