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
        
        HStack{
            Spacer()
            VStack(alignment: .leading){
                Text("Editeur : \(game.gameEditor.editorName)")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
            
            }
            Spacer()
        }
        .padding()
        HStack{
            
            VStack(alignment: .leading, spacing: 40){
           

                if let duration = game.gameDuration {
                    HStack{
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(.newGreen)
                        Text("Durée : \(duration) min")
                            .font(.title3)
                    }
                }
                
                HStack{
                    Image(systemName: "person.3.fill")
                        .foregroundColor(.newGreen)
                    Text("Nombre de joueurs : \(game.gameMinimumPlayers) - \(game.gameMaximumPlayers)")
                        .font(.title3)
                }
            
                HStack{
                    Image(systemName: "person.crop.circle.badge.questionmark")
                        .foregroundColor(.newGreen)
                    Text("Age min: \(game.gameMinimumAge)")
                        .font(.title3)
                }
                HStack{
                    Image(systemName: "folder")
                        .foregroundColor(.newGreen)
                    Text("Catégorie : \(game.gameType)")
                        .font(.title3)
                }
                HStack{
                    Image(systemName: "map")
                        .foregroundColor(.newGreen)
                    Text("Localisation : \(game.gameZone.name)")
                        .font(.title3)
                }
                HStack{
                    Image(systemName: "book")
                        .foregroundColor(.newGreen)
                    Text("Règle : \(game.notice)")
                        .font(.title3)
                }
                if (game.isPrototype){
                    Text("Il s'agit d'un prototype")
                        .font(.title3)
                }
                if (game.isAP){
                    Text("Venez découvrir ce jeu en avant-première !!")
                        .font(.title3)
                }
                
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle(game.gameName)
        Spacer()
        
    }
}


struct GameViewDetailed_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameViewDetailed(game: Game(id: "aa", name: "Monopoly", gameMinimumAge: 5, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 3, gameMaximumPlayers: 10, gameType: "Familiale", gameEditor: Editor(id: "aa", name: "Hachette"), gameZone: Zone(zoneId: "aaa", name: "Zone 2"), isAP: false, notice: "Tout le monde connaît les règles."))
            GameViewDetailed(game: Game(id: "aa", name: "Monopoly", gameMinimumAge: 5, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 3, gameMaximumPlayers: 10, gameType: "Familiale", gameEditor: Editor(id: "aa", name: "Hachette"), gameZone: Zone(zoneId: "aaa", name: "Zone 2"), isAP: false, notice: "Tout le monde connaît les règles."))
        }
    }
}

