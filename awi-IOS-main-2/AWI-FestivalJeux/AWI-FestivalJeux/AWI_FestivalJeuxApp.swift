//
//  AWI_FestivalJeuxApp.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 08/03/2021.
//

import SwiftUI

@main
struct AWI_FestivalJeuxApp: App {
    @StateObject var games = GameList()
    @StateObject var editors = EditorList()
    @StateObject var zones = ZoneList()
    var body: some Scene {
        WindowGroup {
            ContentView(games: games, zones: zones, editors: editors)
        }
    }
}
