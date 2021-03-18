//
//  Festival.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import Foundation

enum FestivalState : CustomStringConvertible, Equatable {
    static func == (lhs: FestivalState, rhs: FestivalState) -> Bool {
        switch (lhs,rhs) {
        case (.loaded,.loaded): return true
        default: return false
        }
    }
    
    case loaded
    case loadingError(Error)
    case loading
    case waiting
    
    var description: String{
        switch self{
        case .loaded : return "loaded"
        case .loadingError(let error) : return "loading error : \(error)"
        case .loading : return "loading"
        case .waiting : return "waiting"
        }
    }
}

class Festival {
    @Published var festivalState: FestivalState = .waiting{
        didSet{
            switch self.festivalState {
            default :
                return
            }
        }
    }
    static let festivalSingleton = Festival()
    var festivalId = -1

    
    private init(){}
}
