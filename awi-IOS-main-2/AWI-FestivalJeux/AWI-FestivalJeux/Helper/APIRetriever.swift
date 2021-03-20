//
//  APIRetriever.swift
//  AWI-FestivalJeux
//
//  Created by etud on 12/03/2021.
//

import Foundation

struct FestivalListData : Codable{
    var results : [FestivalData]
}

struct zoneListData : Codable {
    var results : [ZoneData]
}

struct EditorListData : Codable{
    var results : [EditorData]
}

struct GameListData : Codable{
    var results : [GameData]
}

struct ReservedGameListData : Codable{
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
    
    enum CodingKeys: String, CodingKey {
        case reservedGameId = "_id"
        case reservedGame = "reservationReservedGame"
        case reservedGameZone = "reservationReservedSpace"
        case reservedGameAP
    }
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
    var festivalId : String
    enum CodingKeys: String, CodingKey {
        case festivalId = "_id"
    }
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
    
    
 
    
    static func loadFestivalFromAPI(/*url surl: String,*/ endofrequest: @escaping (Result<Festival,HttpRequestError>) -> Void){
        guard let url = URL(string: APIRetriever.urlCurrentFestival) else {
            endofrequest(.failure(.badURL(APIRetriever.urlCurrentFestival)))
            return
        }
        self.loadFestivalFromJsonData(url: url, endofrequest: endofrequest)
    }

        private static func loadFestivalFromJsonData(url: URL, endofrequest: @escaping (Result<Festival,HttpRequestError>) -> Void, ItuneApiRequest: Bool = true){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decodedData : Decodable?
                    if let jsonString = String(data: data, encoding: .utf8) {
                                print("desc : "+jsonString)
                             }
                    /*if ItuneApiRequest{
                        decodedData = try? JSONDecoder().decode(FestivalListData.self, from: data)
                    }
                    else{*/
                        decodedData = try? JSONDecoder().decode([FestivalData].self, from: data)
                    //}
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    var tracksData : [FestivalData]
                    /*if ItuneApiRequest{
                        tracksData = (decodedResponse as! FestivalListData).results
                    }
                    else{*/
                        tracksData = (decodedResponse as! [FestivalData])
                    //}
                    let festival = self.festivalDatatoFestival(data: tracksData)
                    DispatchQueue.main.async {
                        endofrequest(.success(festival))
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
    
    static func loadGamesFromAPI(/*url surl: String,*/ endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void){
        guard let url = URL(string: APIRetriever.urlGameList) else {
            endofrequest(.failure(.badURL(APIRetriever.urlGameList)))
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
 
                    decodedData = try? JSONDecoder().decode([ReservedGameData].self, from: data)
                    
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    var tracksData : [ReservedGameData]

                    tracksData = (decodedResponse as! [ReservedGameData])
                    
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
    
    static func loadEditorsFromAPI(endofrequest: @escaping (Result<[Editor],HttpRequestError>) -> Void){
        guard let url = URL(string: APIRetriever.urlEditorList) else {
            endofrequest(.failure(.badURL(APIRetriever.urlEditorList)))
            return
        }
        self.loadEditorsFromJsonData(url: url, endofrequest: endofrequest)
    }
    

        private static func loadEditorsFromJsonData(url: URL, endofrequest: @escaping (Result<[Editor],HttpRequestError>) -> Void){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decodedData : Decodable?
 
                    decodedData = try? JSONDecoder().decode([EditorData].self, from: data)
                    
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    var tracksData : [EditorData]

                    tracksData = (decodedResponse as! [EditorData])
                    
                    guard let tracks = self.editorDataToEditors(data: tracksData) else{
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
    
    static func loadZonesFromAPI(endofrequest: @escaping (Result<[Zone],HttpRequestError>) -> Void){
        guard let url = URL(string: APIRetriever.urlZoneList) else {
            endofrequest(.failure(.badURL(APIRetriever.urlZoneList)))
            return
        }
        self.loadZonesFromJsonData(url: url, endofrequest: endofrequest)
    }
    

        private static func loadZonesFromJsonData(url: URL, endofrequest: @escaping (Result<[Zone],HttpRequestError>) -> Void){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decodedData : Decodable?
 
                    decodedData = try? JSONDecoder().decode([ZoneData].self, from: data)
                    
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    var tracksData : [ZoneData]

                    tracksData = (decodedResponse as! [ZoneData])
                    
                    guard let tracks = self.zoneDataToZones(data: tracksData) else{
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
    
    /*
     Used when mapping the editor of a game to the Editor model
     */
    static func editorDataToEditor(data: EditorData) -> Editor {
        return Editor(id: data.editorId, name: data.editorName)
    }
    /*
     Same than above
     */
    static func zoneDataToZone(data: ZoneData) -> Zone {
        return Zone(zoneId: data.zoneId,name: data.zoneName)
    }
    
    
    static func editorDataToEditors(data: [EditorData]) -> [Editor]?{
        var editors = [Editor]()
        for tdata in data{
            let editor = editorDataToEditor(data: tdata)
            editors.append(editor)
        }
        return editors
    }
    

    
    static func zoneDataToZones(data: [ZoneData]) -> [Zone]?{
        var zones = [Zone]()
        for tdata in data{
            let zone = zoneDataToZone(data: tdata)
            zones.append(zone)
        }
        return zones
    }
    
    static func festivalDatatoFestival(data: [FestivalData]) -> Festival {
        let festival = Festival(festivalId: data[0].festivalId)
        return festival
    }
}
