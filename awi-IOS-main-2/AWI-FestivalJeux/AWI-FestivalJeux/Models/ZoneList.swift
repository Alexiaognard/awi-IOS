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
    case loaded
    
    var description: String {
        switch self {
        case .waiting : return "waiting"
        case .loading : return "loading"
        case .loaded : return "loaded"
        }
    }
}

class ZoneList : ObservableObject {
    @Published var zoneListState : ZoneListState = .waiting {
        didSet{
            switch self.zoneListState {
            default: return
            }
        }
    }
    
    @Published var zoneList = [Zone]()
}
