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
    
    @State var textSearch = ""
    
    private var gameListState : GameListState {
        return self.games.gameListState
    }
    
    init(games: GameList, festival: Festival){
        self.games = games
        self.intent = SearchGamesIntent(gameList: games, festival: festival)
        let _  = self.games.$gameListState.sink(receiveValue: stateChanged)
    }
    
    func stateChanged(state: GameListState){
        switch state{
        case .loaded:
            self.intent.gamesLoaded()
        
        default: return
        }
        
    }
    
    private func filterSearch(game: Game) -> Bool{
            var ret = true
            if !textSearch.isEmpty {
                let gameNameLowerCase = game.gameName.lowercased()
                let gameEditorLowerCase = game.gameEditor.editorName.lowercased()
                ret = false
                ret = ret || gameNameLowerCase.contains(textSearch.lowercased())
                ret = ret || gameEditorLowerCase.contains(textSearch.lowercased())
            }
            return ret
        }
    
    var body: some View {
        
        ButtonView(functionToCall: intent.refreshGames,
                           label: "Rafraîchir")
            
                
        TextField("Recherche...",text: $textSearch)
            .font(.footnote)
            .padding()
        ZStack{
            List{
                ForEach(self.games.gameList.filter(filterSearch)){ game in
                    ListItemGame(game:game)
                }
            }
            .padding(.all,0)
            .navigationBarTitle("Liste des jeux")
            .onAppear(perform: intent.loadGames)
            ErrorGameView(state: self.gameListState)
        }
        
    }
}

struct ErrorGameView : View{
    let state : GameListState
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading, .loaded:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1)
                    .padding()
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            Spacer()
        }
    }
}

