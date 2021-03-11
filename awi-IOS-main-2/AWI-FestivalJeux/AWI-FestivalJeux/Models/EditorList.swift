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
    case loaded
    
    var description: String{
        switch self {
        case .waiting : return "waiting"
        case .loading : return "loading"
        case .loaded : return "loaded"
        }
        
    }
}

class EditorList: ObservableObject{
    @Published var editorListState: EditorListState = .waiting{
        didSet{
            switch self.editorListState{
            default: return
            }
        }
    }
    
    @Published var editorList = [Editor]()
}
