//
//  ContentView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 08/03/2021.
//

import SwiftUI

extension UIColor {
    public static var newGreen: UIColor {
        return UIColor(red: 107/255, green: 164/255, blue: 113/255, alpha: 1.0)
    }
}
extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    public static var newGreen: Color {
        return Color(red: 107/255, green: 164/255, blue: 113/255)
    }
    public static var newRed: Color {
        return Color(decimalRed: 173/255, green: 79/255, blue: 79/255)
    }
    

}
struct ContentView: View {
    @ObservedObject var games : GameList
    @ObservedObject var zones : ZoneList
    @ObservedObject var editors : EditorList
    @ObservedObject var festival : Festival
    
    var intentFestival : SearchFestivalIntent
    
    private var festivalState : FestivalState {
        return self.festival.festivalState
    }
    
    init(games: GameList, zones: ZoneList, editors: EditorList, festival: Festival){
        self.games = games
        self.zones = zones
        self.editors = editors
        self.festival = festival
        self.intentFestival = SearchFestivalIntent(festival: festival)
        let _  = self.festival.$festivalState.sink(receiveValue: stateChanged)
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
   
    
    func stateChanged(state: FestivalState){
        switch state {
        case .loaded:
            self.intentFestival.festivalLoaded()
        case .over:
            print("over")
            self.showMenu = false
        default: return
        }
    }
    
    @State private var showMenu = true
    
    
    var body: some View {
        ZStack{
            NavigationView {
                VStack{
                            NavigationLink(destination: GameListView(games: games, festival: self.festival)) {
                                VStack {
                                    Image(systemName: "gamecontroller")
                                        .foregroundColor(.black)
                                        .imageScale(.large)
                                    Text("Jeux")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                }
                            }
                            .padding(.all,50)
                            
                            
                            
                            NavigationLink(destination: EditorListView(editors: editors, festival: self.festival)) {
                                VStack {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.black)
                                        .imageScale(.large)
                                    Text("Editeurs")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                }
                            }
                            .padding(.all,50)
                            NavigationLink(destination: ZoneListView(zones: zones, festival: self.festival)) {
                                VStack {
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .imageScale(.large)
                                Text("Zones")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                 }
                            }
                            .padding(.all,50)
                            
                        
                    }
                    .navigationBarTitle("Menu")
        }
        .onAppear(perform: {
           intentFestival.loadFestival()
        })
        .navigationBarColor(backgroundColor: .newGreen, tintColor: .white)
        //ErrorMainView(state: self.festivalState)
        }
        
    }
}

/*
 // A décommenter (avec la l.118 si on arrive à trouver la solution pour cacher le menu lorsque c'est pas chargé
struct ErrorMainView : View{
    let state : FestivalState
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
 
 */

