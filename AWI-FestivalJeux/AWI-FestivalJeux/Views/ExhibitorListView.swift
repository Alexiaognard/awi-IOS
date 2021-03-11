//
//  ExhibitorListView.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 11/03/2021.
//

import SwiftUI

struct ExhibitorListView: View {
    var exhibitors : [Exhibitor]
    var body: some View {
        List{
            ForEach(exhibitors){ exhibitor in
                NavigationLink(destination: ExhibitorViewDetailed(exhibitor: exhibitor)) {
                    VStack {
                        Text("\(exhibitor.exhibitorName)")
                    }
                }
                .navigationBarTitle("Liste des Exposants")
            }
        }
    }
}

struct ExhibitorListView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitorListView(exhibitors: [
            Exhibitor(id: 1, name: "exposant1",  exhibitorLocalisation: [Zone(name: "Pour tous"), Zone(name: "Ambiance")])
        ])
    }
}
