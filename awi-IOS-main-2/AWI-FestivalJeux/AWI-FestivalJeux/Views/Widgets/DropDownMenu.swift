//
//  DropDownMenu.swift
//  AWI-FestivalJeux
//
//  Created by user190796 on 3/24/21.
//

import SwiftUI

struct IdentifiableString : Identifiable {
    var id = UUID()
    var str: String
}

struct DropDownMenu: View {
    static var name = "Par nom"
    static var editor = "Par éditeur"
    static var zone = "Par zone"
    
    @State var textSearch = ""
    
    
    private var filters : [IdentifiableString]
    private var intent : SearchGamesIntent
    @State var isExpanded = false
    
    init(filterOptions: [String], intent: SearchGamesIntent){
        var array = [IdentifiableString]()
        for str in filterOptions {
            array.append(IdentifiableString(str: str))
        }
        self.filters = array
        self.intent = intent
    }
    
    var body: some View {
        TextField("Recherche...",text: $textSearch).font(.footnote)
        
        
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu(filterOptions: ["aaaa","bbbb","cccc"], intent:SearchGamesIntent(gameList: GameList(), festival: Festival()))
    }
}
