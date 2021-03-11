//
//  ExhibitorView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct ExhibitorViewDetailed: View {
    var exhibitor : Exhibitor
    var listGames = [Game]()
    var localisation = [Zone]()
    
    var body: some View {
        VStack{
            Text("\(exhibitor.exhibitorName)").font(.largeTitle)
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

struct ExhibitorViewDetailed_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitorViewDetailed(exhibitor: Exhibitor(id: 1, name: "exposant1",  exhibitorLocalisation: [Zone(name: "Pour tous"), Zone(name: "Ambiance")]))
    }
}
