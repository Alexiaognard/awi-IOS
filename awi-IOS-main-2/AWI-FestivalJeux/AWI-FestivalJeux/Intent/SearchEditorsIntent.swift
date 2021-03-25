//
//  SearchEditorIntent.swift
//  AWI-FestivalJeux
//
//  Created by etud on 11/03/2021.
//

import Foundation
import SwiftUI

class SearchEditorsIntent {
    @ObservedObject var editorList : EditorList
    @ObservedObject var festival : Festival
    
    init(editorList: EditorList,festival : Festival) {
        self.editorList = editorList
        self.festival = festival
    }
    
    func loadEditors(){
        self.editorList.editorListState = .loading
        //Faire appel à l'API
        APIRetriever.loadEditorsFromAPI(endofrequest: editorsLoaded, festivalId: festival.festivalId)
    }
    
    func editorsLoaded(results: Result<[EditorGameList],HttpRequestError>){
        switch results{
        case let .success(data):
            editorList.editorListState = .loaded(data)
        case let .failure(error):
            editorList.editorListState = .loadingError(error)
        }
    }
    
    func refreshEditors(){
        
    }
    
}
