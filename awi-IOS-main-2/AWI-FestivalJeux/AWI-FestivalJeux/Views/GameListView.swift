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
        let _  = self.games.$gameListState.sink(receiveValue: stateChanged)
    }
    
    func stateChanged(state: GameListState){
        switch state{
        case .loaded, .sorted:
            self.intent.gamesLoaded()
        
        default: return
        }
        
    }
    
    var body: some View {
            VStack{
               
                HStack{
                    Spacer()
                    ButtonView(functionToCall: intent.refreshGames, label: "Rafraîchir")
                }
                HStack{
                DropDownMenu(filterOptions: [DropDownMenu.name,DropDownMenu.editor,DropDownMenu.zone], intent: self.intent)
                    Spacer()
                }
        
                List{
                    Section(header:EmptyView(),footer:EmptyView()){
                        ForEach(self.games.gameList){ game in
                            ListItemGame(game:game)
                        }
                    }
                }
                .navigationBarTitle("Liste des jeux")
                .onAppear(perform: intent.loadGames)

            }
        
    }
}

struct GameListView_Previews: PreviewProvider {
    
    static var previews: some View {
        GameListView(games: GameList(), festival: Festival())
    }
}
