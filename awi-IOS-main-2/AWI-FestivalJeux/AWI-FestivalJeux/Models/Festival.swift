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
    case over
    case loaded(Festival)
    case loadingError(Error)
    case loading
    case waiting
    
    var description: String{
        switch self{
        case .over : return "over"
        case .loaded(let festival) : return "loaded festival id :\(festival.festivalId)"
        case .loadingError(let error) : return "loading error : \(error)"
        case .loading : return "loading"
        case .waiting : return "waiting"
        }
    }
}

class Festival: ObservableObject {
    @Published var festivalState: FestivalState = .waiting{
        didSet{
            switch self.festivalState {
            case let .loaded(data):
                self.festivalId = data.festivalId
            default :
                return
            }
        }
    }
    @Published var festivalId : String

    init(festivalId: String){
        self.festivalId = festivalId
    }
    init(){
        self.festivalId = ""
    }
}
