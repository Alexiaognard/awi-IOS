//
//  EditorListView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct EditorListView: View {
    @ObservedObject var editors : EditorList
    var body: some View {
        List{
            ForEach(self.editors.editorList){ editor in
                NavigationLink(destination: EditorViewDetailed(editor: editor)) {
                    VStack {
                        Text("\(editor.editorName)")
                    }
                }
                .navigationBarTitle("Liste des Editeurs")
            }
        }
    }
}

struct EditorListView_Previews: PreviewProvider {
    static var previews: some View {
        EditorListView(editors: EditorList() /*[
            Editor(id:1, name: "Alexia"),
            Editor(id: 2, name: "Alexia2")
        ]*/)
    }
}
