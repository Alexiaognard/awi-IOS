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
    
    
    private var filters : [IdentifiableString]
    private var intent : IntentFilter
    @State var isExpanded = false
    
    init(filterOptions: [String], intent: IntentFilter){
        var array = [IdentifiableString]()
        for str in filterOptions {
            array.append(IdentifiableString(str: str))
        }
        self.filters = array
        self.intent = intent
    }
    
    var body: some View {
        VStack(){
            VStack(spacing: 20){
                HStack{
                    Text("Filtrer")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.newGreen)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 6)
                        .foregroundColor(.newGreen)
                }.onTapGesture {
                    self.isExpanded.toggle()
                }
                if isExpanded {
                    ForEach(self.filters){ filter in
                        Button(action: {
                                intent.filter(filterOption: filter.str)},
                               label: {
                            Text(filter.str)})
                    }
                    
                }
            }
            .padding()
        }
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu(filterOptions: ["aaaa","bbbb","cccc"], intent:SearchGamesIntent(gameList: GameList(), festival: Festival()))
    }
}
