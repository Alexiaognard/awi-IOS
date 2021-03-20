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
    @ObservedObject var festival : Festival
    
    var intentFestival : SearchFestivalIntent
    var intentGame : SearchGamesIntent
    var intentZone : SearchZonesIntent
    var intentEditor : SearchEditorsIntent
    
    init(games: GameList, zones: ZoneList, editors: EditorList, festival: Festival){
        self.games = games
        self.zones = zones
        self.editors = editors
        self.festival = festival
        self.intentFestival = SearchFestivalIntent(festival: festival)
        self.intentGame = SearchGamesIntent(gameList: games)
        self.intentZone = SearchZonesIntent(zoneList: zones)
        self.intentEditor = SearchEditorsIntent(editorList: editors)
        let _  = self.festival.$festivalState.sink(receiveValue: stateChanged)
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
   
    
    func stateChanged(state: FestivalState){
        print("state changing from "+state.description)
        switch state {
        case .loaded:
            self.intentFestival.festivalLoaded()
            self.showMenu = true
        case .over:
            self.showMenu = true
        default: return
        }
    }
    
    @State private var showMenu = false
    
    
    var body: some View {
        NavigationView {
            /*switch $festival.festivalState {
            case let FestivalState.loaded(data):
            return Text("aaa")
            default: return Text("bbb")
            }*/
           /*if showMenu {
            Text("aaa")
           }else{
            Text("not over "+showMenu.description+" "+self.festival.festivalState.description)
                .onAppear(perform: {
                    intentFestival.loadFestival()
                })
                .opacity(self.showMenu ? 0 : 1)
           }*/
            /* Fonctionne
             Text(festival.festivalState.description).onAppear(perform: {
                intentFestival.loadFestival()
            })*/
            
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
                            .onAppear(perform: {
                                intentFestival.loadFestival()
                            })
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
                }}}}

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
