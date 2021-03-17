//
//  APIRetriever.swift
//  AWI-FestivalJeux
//
//  Created by etud on 12/03/2021.
//

import Foundation

struct zoneListData : Codable {
    var resultCount : Int
    var results : [ZoneData]
}

struct EditorListData : Codable{
    var resultCount : Int
    var results : [EditorData]
}

struct GameListData : Codable{
    var resultCount : Int
    var results : [GameData]
}

struct ReservedGameListData : Codable{
    var resultCount : Int
    var results : [ReservedGameData]
}

struct ZoneData : Codable{
    var zoneId : Int
    var zoneName : String
}

struct EditorData : Codable{
    var editorId : Int
    var editorName : String
}

struct ReservedGameData : Codable {
    var reservedGameId : Int
    var reservedGame : GameData
    var reservedGameZone : ZoneData
    var reservedGameAP : Bool
}

struct GameData : Codable{
    var gameId : Int
    var gameName : String
    var gameMinimumAge : Int
    var gameDuration : Int?
    var isPrototype : Bool
    var gameMinimumPlayers : Int
    var gameMaximumPlayers : Int
    var gameType : String
    var gameEditor : EditorData
    var gameNotice : String
}

struct FestivalData : Codable {
    var festivalId : Int
    var festivalName : String?
    var festivalData : Date
}

/*
 Static methods used to retrieve the data from the API asynchronously
 */
struct APIRetriever {
    static var api="https://awi-api.herokuapp.com"
    static var urlCurrentFestival=api+"/festival/current/"
    static var urlGameList="/game/list/festival"
    static var urlEditorList="/editor/list"
    static var urlZoneList="/zone/list"
    
    static func loadGamesFromAPI(/*url surl: String,*/ endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void){
            guard let url = URL(string: urlCurrentFestival) else {
                endofrequest(.failure(.badURL(urlCurrentFestival)))
                return
            }
            self.loadGamesFromAPI(url: url, endofrequest: endofrequest)
        }
        static func loadGamesFromAPI(url: URL, endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void){
            self.loadGamesFromJsonData(url: url, endofrequest: endofrequest, ItuneApiRequest: true)
        }

        private static func loadGamesFromJsonData(url: URL, endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void, ItuneApiRequest: Bool = true){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decodedData : Decodable?
                    if ItuneApiRequest{
                        decodedData = try? JSONDecoder().decode(ReservedGameListData.self, from: data)
                    }
                    else{
                        decodedData = try? JSONDecoder().decode([ReservedGameData].self, from: data)
                    }
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    var tracksData : [ReservedGameData]
                    if ItuneApiRequest{
                        tracksData = (decodedResponse as! ReservedGameListData).results
                    }
                    else{
                        tracksData = (decodedResponse as! [ReservedGameData])
                    }
                    guard let tracks = self.reservedGameDataToGames(data: tracksData) else{
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    DispatchQueue.main.async {
                        endofrequest(.success(tracks))
                    }
                }
                else{
                    DispatchQueue.main.async {
                        if let error = error {
                            guard let error = error as? URLError else {
                                endofrequest(.failure(.unknown))
                                return
                            }
                            endofrequest(.failure(.failingURL(error)))
                        }
                        else{
                            guard let response = response as? HTTPURLResponse else{
                                endofrequest(.failure(.unknown))
                                return
                            }
                            guard response.statusCode == 200 else {
                                endofrequest(.failure(.requestFailed))
                                return
                            }
                            endofrequest(.failure(.unknown))
                        }
                    }
                }
            }.resume()
        }
    
    static func reservedGameDataToGames(data: [ReservedGameData]) -> [Game]?{
        var games = [Game]()
        var game : GameData
        var editor : Editor
        var zone : Zone
            for tdata in data{
               /* guard (tdata.collectionId != nil) || (tdata.trackId != nil) else{
                    return nil
                }*/
                game = tdata.reservedGame
                editor = editorDataToEditor(data: game.gameEditor)
                zone = zoneDataToZone(data: tdata.reservedGameZone)
                let track = Game(id: game.gameId, name: game.gameName, gameMinimumAge: game.gameMinimumAge, gameDuration: game.gameDuration, isPrototype: game.isPrototype, gameMinimumPlayers: game.gameMinimumPlayers, gameMaximumPlayers: game.gameMaximumPlayers, gameType: game.gameType, gameEditor: editor, gameZone: zone, isAP: tdata.reservedGameAP, notice: game.gameNotice)
                games.append(track)
            }
            return games
        }
    
    static func editorDataToEditor(data: EditorData) -> Editor {
        return Editor(id: data.editorId, name: data.editorName)
    }
    
    
    static func editorDataToEditors(data: [EditorData]) -> [Editor]?{
        var editors = [Editor]()
        for tdata in data{
            let editor = editorDataToEditor(data: tdata)
            editors.append(editor)
        }
        return editors
    }
    
    static func zoneDataToZone(data: ZoneData) -> Zone {
        return Zone(zoneId: data.zoneId,name: data.zoneName)
    }
    
    static func zoneDataToZones(data: [ZoneData]) -> [Zone]?{
        var zones = [Zone]()
        for tdata in data{
            let zone = zoneDataToZone(data: tdata)
            zones.append(zone)
        }
        return zones
    }
}
