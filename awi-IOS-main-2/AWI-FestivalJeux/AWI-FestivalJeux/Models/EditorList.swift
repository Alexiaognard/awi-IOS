//
//  EditorListView.swift
//  AWI-FestivalJeux
//
//  Created by etud on 11/03/2021.
//

import Foundation

enum EditorListState: CustomStringConvertible{
    case waiting
    case loading
    case loadingError(Error)
    case loaded([EditorGameList])
    case over
    
    var description: String{
        switch self {
        case .waiting : return "waiting"
        case .loading : return "loading"
        case .loadingError(let error): return "loading error : \(error)"
        case .loaded(let editors) : return "loaded \(editors.count) editors"
        case .over: return "over"

        }
        
    }
}

class EditorList: ObservableObject{
    @Published var editorListState: EditorListState = .waiting{
        didSet{
            switch self.editorListState{
            case let .loaded(data):
                self.new(data)
            default: return
            }
        }
    }
    
    @Published var editorList = [EditorGameList]()
    
    func new(_ editors: [EditorGameList]){
        self.editorList = editors
        self.editorListState = .waiting
    }
}
