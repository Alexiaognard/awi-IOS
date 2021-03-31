//
//  EditorViewDetailed.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct EditorViewDetailed: View {
    @ObservedObject var editor : EditorGameList
    var intent : SearchGamesFromEditorIntent
    
    private var editorState : EditorState {
        return self.editor.editorState
    }
    
    init(editor: EditorGameList,festival: Festival) {
        self.editor = editor
        self.intent = SearchGamesFromEditorIntent(editor: editor, festival: festival)
        let _  = self.editor.$editorState.sink(receiveValue: stateChanged)
    }
    
    func stateChanged(state: EditorState){
        switch state {
        case .loaded:
            //Fonctionne pas ???????
            //Déplacé dans le new du model
            return  
            //self.intent.editorGamesLoaded()
        default: return
        }
    }
    
    var body: some View {
        ZStack{
            Text("Jeux proposés :").font(.title2)
            List{
                ForEach(self.editor.gameList){ game in
                    ListItemGame(game: game)
                }
            }
            .onAppear(perform: {
                self.intent.loadEditorGames(editorId: self.editor.editorId)
            })
            .navigationBarTitle(self.editor.editorName)
            ErrorEditorView(state: self.editorState)
        }
    }
}

struct ErrorEditorView : View{
    let state : EditorState
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading, .loaded:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1)
                    .padding()
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            Spacer()
        }
    }
}
