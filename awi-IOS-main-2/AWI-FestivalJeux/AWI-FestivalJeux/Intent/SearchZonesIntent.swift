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
    
    init(zoneList: ZoneList) {
        self.zoneList = zoneList
    }
    
    func loadGames(){
        self.zoneList.zoneListState = .loading
        //Faire appel à l'API
    }
    
    func gamesLoaded(){
        self.zoneList.zoneListState = .loaded
    }
}
