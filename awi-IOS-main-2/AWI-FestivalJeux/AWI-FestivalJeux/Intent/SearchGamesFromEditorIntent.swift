//
//  SearchGamesFromEditorIntent.swift
//  AWI-FestivalJeux
//
//  Created by user190227 on 3/26/21.
//

import Foundation
import SwiftUI

class SearchGamesFromEditorIntent {
    @ObservedObject var editor : EditorGameList
    @ObservedObject var festival : Festival
    
    init(editor: EditorGameList,festival : Festival) {
        self.editor = editor
        self.festival = festival
    }
    
    func loadEditorGames(editorId: String){
        switch editor.editorState{
        case .waiting:
            self.editor.editorState = .loading
            //Faire appel à l'API
            APIRetriever.loadEditorGamesFromAPI(endofrequest: editorGamesLoaded, festivalId: festival.festivalId, editorId: editorId)
        default: return
        }
    }
    
    func editorGamesLoaded(results: Result<[Game],HttpRequestError>){
        switch results{
        case let .success(data):
            editor.editorState = .loaded(data)
        case let .failure(error):
            editor.editorState = .loadingError(error)
        }
    }
    
    func editorGamesLoaded(){
        self.editor.editorState = .over
    }

    
}
