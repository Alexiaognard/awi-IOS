//
//  FileView.swift
//  AWI-FestivalJeux
//
//  Created by user190796 on 3/24/21.
//

import SwiftUI



struct ListItemGame: View {
    private var game: Game
      
    init(game: Game){
        self.game = game
    }
 
    
    
      var body: some View {
        NavigationLink(destination: GameViewDetailed(game: game)) {
          ZStack(alignment: .leading) {
              
              Color.newGreen
                HStack{
                  VStack(alignment: .leading) {
                    
                    Text(game.gameName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .foregroundColor(.white)
                    
                    HStack{
                        HStack(alignment: .center) {
                            Image(systemName: "pencil")
                            Text(game.gameEditor.editorName)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        HStack{
                            Image(systemName: "house")
                            Text(game.gameZone.name)
                                .foregroundColor(.white)
                        }
                    }
                      
                    ZStack {
                        Text(game.gameType)
                                .font(.system(size: 12.0, weight: .regular))
                                .lineLimit(2)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.newRed)
                                .cornerRadius(5)
                        }
                  }
                  .padding(.horizontal, 5)
              }
                .padding(.horizontal,15)
                .padding(.vertical,5)
          }
          .clipShape(RoundedRectangle(cornerRadius: 15))
        }
      }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemGame(game: Game(id: "aa", name: "Monopoly", gameMinimumAge: 5, gameDuration: 301, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 10, gameType: "Familiale", gameEditor: Editor(id: "aa", name: "Hachette"), gameZone: Zone(zoneId: "aa", name: "Zone 1"), isAP: false, notice: "Tout le monde connaît les règles"))
    }
}
