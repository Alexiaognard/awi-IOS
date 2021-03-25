//
//  ZoneViewDetail.swift
//  AWI-FestivalJeux
//
//  Created by etud on 12/03/2021.
//

import SwiftUI

struct ZoneViewDetailed: View {
    var zone : ZoneGameList
    var body: some View {
        List{
            ForEach(self.zone.gameList){ game in
                ListItemGame(game: game)
            }
        }
        .navigationBarTitle(zone.name)
    }
}

/*struct ZoneViewDetailed_Previews: PreviewProvider {
    static var previews: some View {
        ZoneViewDetailed()
    }
}
*/
