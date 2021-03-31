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
    
    @State var textSearch = ""
    
    private var zoneListState : ZoneListState {
        return self.zones.zoneListState
    }
    
    init(zones : ZoneList, festival: Festival){
        self.zones = zones
        self.intent = SearchZonesIntent(zoneList: zones, festival: festival)
        let _  = self.zones.$zoneListState.sink(receiveValue: stateChanged)
    }
    
    private func filterSearch(zone: ZoneGameList) -> Bool{
            var ret = true
            if !textSearch.isEmpty {
                let zoneNameLowerCase = zone.name.lowercased()
                ret = false
                ret = ret || zoneNameLowerCase.contains(textSearch.lowercased())
            }
            return ret
    }
    
    func stateChanged(state: ZoneListState){
        switch state {
        case .loaded:
            self.intent.zonesLoaded()
        default: return
        }
    }
    
    var body: some View {
        ButtonView(functionToCall: intent.refreshZones, label: "Rafraîchir")
        TextField("Recherche...",text: $textSearch)
            .font(.footnote)
            .padding()
        ZStack{
            List{
                ForEach(self.zones.zoneList.filter(filterSearch)){ zone in
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
