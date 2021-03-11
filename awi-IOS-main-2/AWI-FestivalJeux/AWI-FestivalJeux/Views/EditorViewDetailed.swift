//
//  EditorViewDetailed.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct EditorViewDetailed: View {
    var editor : Editor
    var listGames = [Game]()
    var localisation = [Zone]()
    
    var body: some View {
        VStack{
            Text("\(editor.editorName)").font(.largeTitle)
            Divider()
            
            Text("Jeux proposés :").font(.title2)
            List{
                ForEach(listGames){ game in
                    NavigationLink(destination: GameViewDetailed(game: game)) {
                        VStack {
                            Text("\(game.gameName)")
                        }
                    }
                    
                }
            }
            
            Divider()
            Text("Localisation :").font(.title2)
            List{
                ForEach(localisation){ loc in
                    Text("\(loc.name)")
                }
            }
            Spacer()
            
        }
    }
}

struct EditorViewDetailed_Previews: PreviewProvider {
    static var previews: some View {
        EditorViewDetailed(
            editor: Editor(id: 1, name: "Hasbro"),
            listGames: [Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Famille"), isAP: false),
                Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Pour tous"), isAP: false)
            ],
            localisation: [Zone(name: "Famille"), Zone(name: "Pour tous")])
    }
}
