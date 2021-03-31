//
//  EditorListView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct EditorListView: View {
    @ObservedObject var editors : EditorList
    @ObservedObject var festival : Festival
    var intent : SearchEditorsIntent
    
    private var editorListState : EditorListState {
        return self.editors.editorListState
    }
    
    @State var textSearch = ""
    
    init(editors: EditorList, festival: Festival){
        self.editors = editors
        self.festival = festival
        self.intent = SearchEditorsIntent(editorList: editors, festival: festival)
        let _  = self.editors.$editorListState.sink(receiveValue: stateChanged)
    }
    
    func stateChanged(state: EditorListState){
        switch state {
        case .loaded:
            self.intent.editorsLoaded()
        default: return
        }
    }
    
    private func filterSearch(editor: EditorGameList) -> Bool{
            var ret = true
            if !textSearch.isEmpty {
                let editorNameLowerCase = editor.editorName.lowercased()
                ret = false
                ret = ret || editorNameLowerCase.contains(textSearch.lowercased())
            }
            return ret
        }
    
    var body: some View {


        ButtonView(functionToCall: intent.refreshEditors, label: "Rafraîchir")
            
            
        TextField("Recherche...",text: $textSearch)
            .font(.footnote)
            .padding()
        ZStack{
            List{
                ForEach(self.editors.editorList.filter(filterSearch)){ editor in
                    NavigationLink(destination: EditorViewDetailed(editor: editor,festival: festival)) {
                        VStack {
                            ListItemEditor(editor: editor)
                        }
                    }
                    .navigationBarTitle("Liste des éditeurs")
                }
            }
            .onAppear(perform: intent.loadEditors)
            ErrorEditorListView(state: self.editorListState)
        }
    }
}

struct ErrorEditorListView : View{
    let state : EditorListState
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
