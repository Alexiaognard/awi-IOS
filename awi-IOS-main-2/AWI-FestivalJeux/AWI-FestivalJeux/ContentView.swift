//
//  ContentView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 08/03/2021.
//

import SwiftUI

struct ContentView: View {
    //aa
    @State var games = GameList()
    @State var editors = EditorList()
    @State var zones : ZoneList = ZoneList()
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        return NavigationView {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            /*games: [Game(id: 1, name: "Monopoly", gameMinimumAge: 6, gameDuration: 30, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 6, gameType: "Famille", gameEditor: Editor(id: 1, name: "Editeur1"), gameZone: Zone(name: "Famille"), isAP: false)],
            editors: [Editor(id:1, name: "Editor1"), Editor(id:2, name: "Editor2")],
            exhibitors: [Exhibitor(id: 1, name: "exposant1",  exhibitorLocalisation: [Zone(name: "Pour tous"), Zone(name: "Ambiance")])]*/
        )
    }
}
