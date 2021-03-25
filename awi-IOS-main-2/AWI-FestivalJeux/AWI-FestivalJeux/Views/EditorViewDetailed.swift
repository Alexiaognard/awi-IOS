//
//  EditorViewDetailed.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct EditorViewDetailed: View {
    var editor : EditorGameList
    
    var body: some View {
        Text("Jeux proposés :").font(.title2)
        List{
            ForEach(self.editor.gameList){ game in
                ListItemGame(game: game)
            }
        }
        .navigationBarTitle(self.editor.editorName)
            
           
            
        
    }
}

/*struct EditorViewDetailed_Previews: PreviewProvider {
    static var previews: some View {
        EditorViewDetailed(
            editor: Editor(id: 1, name: "Hasbro"),
            listGames: [Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Famille"), isAP: false),
                Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Pour tous"), isAP: false)
            ],
            localisation: [Zone(name: "Famille"), Zone(name: "Pour tous")])
    }
}*/
