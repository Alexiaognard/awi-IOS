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
        switch self.zoneList.zoneListState {
        case .waiting:
            self.zoneList.zoneListState = .loading
            //Faire appel à l'API
            APIRetriever.loadZonesFromAPI(endofrequest: zoneJsonloaded, festivalId: festival.festivalId)
        default: return
        }
    }
    
    func zoneJsonloaded(results: Result<[ZoneGameList],HttpRequestError>){
        switch results{
        case let .success(data):
            self.zoneList.zoneListState = .loaded(data)
        case let .failure(error):
            self.zoneList.zoneListState = .loadingError(error)
        }
    }
    
    func zonesLoaded(){
        self.zoneList.zoneListState = .over
    }
    
    func refreshZones(){
        switch zoneList.zoneListState{
        case .over:
            self.zoneList.zoneListState = .loading
            APIRetriever.loadZonesFromAPI(endofrequest: zoneJsonloaded, festivalId: festival.festivalId)
        default: return
        }
    }
}
