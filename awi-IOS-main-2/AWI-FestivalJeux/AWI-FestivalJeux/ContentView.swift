//
//  ContentView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 08/03/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var games : GameList
    @ObservedObject var zones : ZoneList
    @ObservedObject var editors : EditorList
 
    var festival = Festival.festivalSingleton
    
    var intentFestival : SearchFestivalIntent
    var intentGame : SearchGamesIntent
    var intentZone : SearchZonesIntent
    var intentEditor : SearchEditorsIntent
    
    init(games: GameList, zones: ZoneList, editors: EditorList){
        self.games = games
        self.zones = zones
        self.editors = editors
        self.intentFestival = SearchFestivalIntent()
        self.intentGame = SearchGamesIntent(gameList: games)
        self.intentZone = SearchZonesIntent(zoneList: zones)
        self.intentEditor = SearchEditorsIntent(editorList: editors)
        let _  = self.festival.$festivalState.sink(receiveValue: stateChanged)
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
   
    
    func stateChanged(state: FestivalState){
        switch state {
        
        default: return
        }
    }
    
    var body: some View {
        NavigationView {
            if festival.festivalState == .loaded {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                        Spacer()
                        LazyVGrid(columns: columns, spacing: 70) {
                            
                            NavigationLink(destination: GameListView(games: games)) {
                                VStack {
                                    Image(systemName: "gamecontroller")
                                        .foregroundColor(.black)
                                        .imageScale(.large)
                                    Text("Jeux")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                }
                            }
                            .navigationBarTitle("Menu")
                            
                            NavigationLink(destination: EditorListView(editors: editors)) {
                                VStack {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                        .imageScale(.large)
                                    Text("Editeurs")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                }
                            }
                            .navigationBarTitle("Menu")
                            
                            NavigationLink(destination: ZoneListView(zones: zones)) {
                                VStack {
                                    Image(systemName: "house")
                                        .foregroundColor(.black)
                                        .imageScale(.large)
                                    Text("Zones")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                }
                            }
                            .navigationBarTitle("Menu")
                        }
                        .padding(.horizontal)
                }
            }
            }else{
                Text("LOADING...")
            }
        }
        .onAppear(perform: {
            intentFestival.loadFestival()
        })
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            /*games: [Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Famille"), isAP: false)],
            editors: [Editor(id:1, name: "Editor1"), Editor(id:2, name: "Editor2")],
            exhibitors: [Exhibitor(id: 1, name: "exposant1",  exhibitorLocalisation: [Zone(name: "Pour tous"), Zone(name: "Ambiance")])]*/
        )
    }
}*/
