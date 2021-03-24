//
//  FileView.swift
//  AWI-FestivalJeux
//
//  Created by user190796 on 3/24/21.
//

import SwiftUI



struct ListItemGame: View {
    private var game: Game
    private var showEverything: Bool
      
    init(game: Game, showEverything: Bool){
        self.game = game
        self.showEverything = showEverything
    }
 
    
    
      var body: some View {
          ZStack(alignment: .leading) {
              
              Color.newGreen
                HStack{
                  VStack(alignment: .leading) {
                    
                    
                    Text(game.gameName)
                          .font(.headline)
                          .fontWeight(.bold)
                          .lineLimit(2)
                        .foregroundColor(.white)
                        
                      
                    Text(game.gameZone.name)
                          .padding(.bottom, 5)
                        .foregroundColor(.white)
                      
                      HStack(alignment: .center) {
                          Image(systemName: "pencil")
                        Text(game.gameEditor.editorName)
                            .foregroundColor(.white)
                      }
                      .padding(.bottom, 5)
                      
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
              .padding(15)
          }
          .clipShape(RoundedRectangle(cornerRadius: 15))
      }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemGame(game: Game(id: "aa", name: "Monopoly", gameMinimumAge: 5, gameDuration: 301, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 10, gameType: "Familiale", gameEditor: Editor(id: "aa", name: "Hachette"), gameZone: Zone(zoneId: "aa", name: "Zone 1"), isAP: false, notice: "Tout le monde connaît les règles"),showEverything:false)
    }
}
