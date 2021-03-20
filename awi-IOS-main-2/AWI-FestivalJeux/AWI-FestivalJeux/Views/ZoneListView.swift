//
//  ZoneList.swift
//  AWI-FestivalJeux
//
//  Created by etud on 12/03/2021.
//

import SwiftUI

struct ZoneListView: View {
    @ObservedObject var zones : ZoneList
    var intent : SearchZonesIntent
    
    init(zones : ZoneList){
        self.zones = zones
        self.intent = SearchZonesIntent(zoneList: zones)
        self.intent.loadZones()
    }
    var body: some View {
        List{
            ForEach(self.zones.zoneList){ zone in
                NavigationLink(destination: ZoneViewDetailed(zone: zone)) {
                    VStack {
                        Text("\(zone.name)")
                    }
                }
                .navigationBarTitle("Liste des zones")
            }
        }
    }
}

struct ZoneListView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneListView(zones: ZoneList())
    }
}
