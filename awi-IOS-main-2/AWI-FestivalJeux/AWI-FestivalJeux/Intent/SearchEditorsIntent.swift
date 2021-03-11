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
    
    func loadGames(){
        self.editorList.editorListState = .loading
        //Faire appel à l'API
    }
    
    func gamesLoaded(){
        self.editorList.editorListState = .loaded
    }
}
