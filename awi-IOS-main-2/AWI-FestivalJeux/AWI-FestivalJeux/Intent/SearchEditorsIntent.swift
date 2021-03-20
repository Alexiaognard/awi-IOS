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
    
    init(editorList: EditorList) {
        self.editorList = editorList
    }
    
    func loadEditors(){
        self.editorList.editorListState = .loading
        //Faire appel à l'API
        APIRetriever.loadEditorsFromAPI(endofrequest: editorsLoaded)
    }
    
    func editorsLoaded(results: Result<[Editor],HttpRequestError>){
        switch results{
        case let .success(data):
            editorList.editorListState = .loaded(data)
        case let .failure(error):
            editorList.editorListState = .loadingError(error)
        }
    }
}
