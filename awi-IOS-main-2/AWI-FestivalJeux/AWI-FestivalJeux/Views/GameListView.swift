//
//  GameListView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct GameListView: View {
    @ObservedObject var games : GameList
    var intent : SearchGamesIntent
    
    init(games: GameList){
        self.games = games
        self.intent = SearchGamesIntent(gameList: games)
        self.intent.loadGames()
    }
    
    var body: some View {
        List{
            ForEach(self.games.gameList){ game in
                NavigationLink(destination: GameViewDetailed(game: game)) {
                    VStack {
                        Text("\(game.gameName)")
                    }
                }
                .navigationBarTitle("Liste des Jeux")
            }
        }
    }
}

/*struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(games: GameList(), intent: SearchGamesIntent()/*games: [
                        Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Famille"), isAP: false),
                        Game(id: 2, name: "Monopoly2", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur2"), gameZone: Zone(name: "Famille"), isAP: false)
        ]*/)
    }
}*/
