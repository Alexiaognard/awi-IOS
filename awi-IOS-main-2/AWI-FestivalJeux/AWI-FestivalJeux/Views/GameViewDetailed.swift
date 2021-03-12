//
//  GameView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct GameViewDetailed: View {
    var game : Game
    var body: some View {
        VStack{
            Text("\(game.gameName)").font(.largeTitle)
            Text("Editeur : \(game.gameEditor.editorName)").foregroundColor(.gray)
            
            Divider()
            
            HStack{
                Image(systemName: "clock.arrow.circlepath")
                Text("Durée : \(game.gameDuration) min")
            }
            HStack{
                Image(systemName: "person.3.fill")
                Text("Nombre de joueurs : \(game.gameMinimumPlayers) - \(game.gameMaximumPlayers)")
            }
            HStack{
                Image(systemName: "person.crop.circle.badge.questionmark")
                Text("Age min: \(game.gameMinimumAge)")
            }
            HStack{
                Image(systemName: "folder")
                Text("Catégorie : \(game.gameType)")
            }
            HStack{
                Image(systemName: "map")
                Text("Localisation : \(game.gameZone.name)")
            }
            if (game.isPrototype){
                Text("Il s'agit d'un prototype")
            }
            if (game.isAP){
                Text("Venez découvrir ce jeu en avant-première !!")
            }
            
        }
    }
}

struct GameViewDetailed_Previews: PreviewProvider {
    static var previews: some View {
        GameViewDetailed(game: Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Famille"), isAP: false, notice: "ceci est une notice"))
    }
}
