//
//  ListItemZone.swift
//  AWI-FestivalJeux
//
//  Created by etud on 25/03/2021.
//

import SwiftUI

struct ListItemZone: View {
    private var zone : ZoneGameList
    
    init(zone: ZoneGameList){
        self.zone = zone
    }
    
    var body: some View {
        VStack{
            Text(zone.name)
                .font(.title)
            Text("Nombre de jeux : \(zone.gameList.count)")
        }
    }
}

/*struct ListItemZone_Previews: PreviewProvider {
    static var previews: some View {
        ListItemZone()
    }
}*/
