//
//  FileView.swift
//  AWI-FestivalJeux
//
//  Created by user190796 on 3/24/21.
//

import SwiftUI



struct ListItemGame: View {
    private var game: Game
    public static var paddingValue :CGFloat = 7
      
    init(game: Game){
        self.game = game
    }
 
    
    
      var body: some View {
        NavigationLink(destination: GameViewDetailed(game: game)) {
            VStack{
                HeaderItem(gameName: self.game.gameName)
                    .padding(.leading,ListItemGame.paddingValue)
                    .padding(.top,ListItemGame.paddingValue)
                    .background(Color.newGreen)
                    .cornerRadius(radius: 6, corners: [.topLeft, .topRight])
                ContentItem(editorName: self.game.gameEditor.editorName, zoneName: self.game.gameZone.name, gameType: self.game.gameType)
                    .padding(.bottom,ListItemGame.paddingValue)
                    .padding(.leading,ListItemGame.paddingValue)
                    .padding(.trailing,ListItemGame.paddingValue)
                    .background(Color.lightGreen)
                    .cornerRadius(radius: 6, corners: [.bottomLeft, .bottomRight])
            }
          /*ZStack(alignment: .leading) {
              
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
              }
                .padding(.horizontal,15)
                .padding(.vertical,5)
          }
          //.clipShape(RoundedRectangle(cornerRadius: 15))
 */
        }
        /*.listRowBackground(Section(
            header: HeaderItem(gameName: self.game.gameName)
        ){
            /*ContentItem(editorName: self.game.gameEditor.editorName, zoneName: self.game.gameZone.name, gameType: self.game.gameType)*/
        })*/
      }
}

struct HeaderItem: View {
    let gameName: String
    
    var body: some View {
        HStack{
            Text(self.gameName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        
        
    }
}

struct ContentItem: View {
    let editorName: String
    let zoneName: String
    let gameType: String
    
    var body: some View {
        VStack{
            HStack{
                HStack(alignment: .center) {
                    Image(systemName: "pencil")
                    Text(editorName)
                }
                Spacer()
                HStack{
                    Image(systemName: "house")
                    Text(zoneName)
                        .padding(.all,ListItemGame.paddingValue)

                }
            }
                        
            ZStack {
                HStack{
                    Text(gameType)
                            .font(.system(size: 12.0, weight: .regular))
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.newRed)
                            .cornerRadius(5)
                    Spacer()
                }
                }
        }
        
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemGame(game: Game(id: "aa", name: "Monopoly", gameMinimumAge: 5, gameDuration: 301, isPrototype: false, gameMinimumPlayers: 2, gameMaximumPlayers: 10, gameType: "Familiale", gameEditor: Editor(id: "aa", name: "Hachette"), gameZone: Zone(zoneId: "aa", name: "Zone 1"), isAP: false, notice: "Tout le monde connaît les règles"))
    }
}
