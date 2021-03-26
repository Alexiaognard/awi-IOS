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
    
    private var zoneListState : ZoneListState {
        return self.zones.zoneListState
    }
    
    init(zones : ZoneList, festival: Festival){
        self.zones = zones
        self.intent = SearchZonesIntent(zoneList: zones, festival: festival)
    }
    
    var body: some View {
        ButtonView(functionToCall: intent.refreshZones, label: "Rafraîchir")
        ZStack{
            List{
                ForEach(self.zones.zoneList){ zone in
                    NavigationLink(destination: ZoneViewDetailed(zone: zone)) {
                            ListItemZone(zone: zone)
                    }
                }
            }
            .onAppear(perform: {
                intent.loadZones()
            })
            .navigationBarTitle("Liste des zones")
            ErrorZoneView(state: self.zoneListState)
        }
    }
}

 struct ErrorZoneView : View{
     let state : ZoneListState
     var body: some View{
         VStack{
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
         }
     }
 }
