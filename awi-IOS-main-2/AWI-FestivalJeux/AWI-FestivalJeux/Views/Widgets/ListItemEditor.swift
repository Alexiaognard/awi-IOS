//
//  ListItemEditor.swift
//  AWI-FestivalJeux
//
//  Created by etud on 24/03/2021.
//

import SwiftUI

struct ListItemEditor: View {
    private var editor: Editor
    
    init(editor: Editor){
        self.editor = editor
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
           
              HStack{
                VStack(alignment: .leading) {
                    Text(self.editor.editorName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                }
            }
        }
    }
}

struct ListItemEditor_Previews: PreviewProvider {
    static var previews: some View {
        ListItemEditor(editor: Editor(id: "aa", name: "Hachette"))
    }
}
