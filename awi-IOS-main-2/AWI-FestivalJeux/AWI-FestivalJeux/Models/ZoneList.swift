//
//  ZoneList.swift
//  AWI-FestivalJeux
//
//  Created by etud on 12/03/2021.
//

import SwiftUI

enum ZoneListState: CustomStringConvertible {
    case waiting
    case loading
    case loadingError(Error)
    case loaded([ZoneGameList])
    case over
    
    var description: String {
        switch self {
        case .waiting : return "waiting"
        case .loading : return "loading"
        case .loadingError(let error): return "loading error : \(error)"
        case .loaded(let zones) : return "loaded \(zones.count) zones"
        case .over : return "over"
        }
    }
}

class ZoneList : ObservableObject {
    @Published var zoneListState : ZoneListState = .waiting {
        didSet{
            switch self.zoneListState {
            case let .loaded(data):
                self.new(data)
            default: return
            }
        }
    }
    
    @Published var zoneList = [ZoneGameList]()
    
    func new(_ zones: [ZoneGameList]){
        self.zoneList = zones
    }
}
