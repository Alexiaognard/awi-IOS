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
    
    init(games: GameList, festival: Festival){
        self.games = games
        self.intent = SearchGamesIntent(gameList: games, festival: festival)
    }
    
    var body: some View {
            VStack{
                Spacer()
                HStack{
                    DropDownMenu(filterOptions: [DropDownMenu.name,DropDownMenu.editor,DropDownMenu.zone], intent: self.intent)
                    Spacer()
                    ButtonView(functionToCall: intent.loadGames, label: "Rafraîchir")
                }
                
        
                List{
                    Section(header:EmptyView(),footer:EmptyView()){
                        ForEach(self.games.gameList){ game in
                            NavigationLink(destination: GameViewDetailed(game: game)) {
                                ListView(game:game,showEverything: false)
                            }
                            .navigationBarTitle("Liste des Jeux")
                        }
                    }
                }
                .onAppear(perform: intent.loadGames)
              
                
            }
        
    }
}

struct GameListView_Previews: PreviewProvider {
    
    static var previews: some View {
        GameListView(games: GameList(), festival: Festival())
    }
}
