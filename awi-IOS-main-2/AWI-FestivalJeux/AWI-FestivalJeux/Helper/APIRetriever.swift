//
//  APIRetriever.swift
//  AWI-FestivalJeux
//
//  Created by etud on 12/03/2021.
//

import Foundation


struct ZoneData : Codable{
    var zoneId : String
    var zoneName : String
    
    enum CodingKeys: String, CodingKey{
        case zoneId = "_id"
        case zoneName
    }
}

struct ZoneGameListData : Codable {
    var zone : ZoneData
    var gameList : [ReservedGameData]
    
    enum CodingKeys: String, CodingKey{
        case zone, gameList
    }
}

struct EditorData : Codable{
    var editorId : String
    var editorName : String
    
    enum CodingKeys : String, CodingKey {
        case editorId = "_id"
        case editorName
    }
}


struct ReservationData : Codable {
    var reservedGame : [ReservedGameData]
    
    enum CodingKeys: String, CodingKey {
        case reservedGame = "reservationReservedGame"
    }
}

struct ReservedGameData : Codable {
    var isAP : Bool
    var game : GameData
    var zone : ZoneData
    
    enum CodingKeys: String, CodingKey{
        case isAP = "reservedGameAP"
        case game = "reservedGame"
        case zone = "reservedGameZone"
    }
}

struct GameData : Codable{
    var gameId : String
    var gameName : String
    var gameMinimumAge : Int
    var gameDuration : Int?
    var isPrototype : Bool
    var gameMinimumPlayers : Int
    var gameMaximumPlayers : Int
    var gameType : GameTypeData
    var gameEditor : EditorData
    var gameNotice : String
    
    enum CodingKeys: String, CodingKey{
        case gameId = "_id"
        case gameName
        case gameMinimumAge
        case gameDuration
        case isPrototype
        case gameMinimumPlayers
        case gameMaximumPlayers
        case gameType
        case gameEditor
        case gameNotice
    }
}

struct GameTypeData : Codable {
    var gameTypeName : String
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
    static var urlGameList=api+"/game/list/festival"
    static var urlEditorList=api+"/editor/list/festival"
    static var urlEditorGamesList=api+"/game/list/editor"
    static var urlZoneList=api+"/zone/list/festival"
    
 
    
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
                    //Print the received JSON
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
    
    static func loadGamesFromAPI(/*url surl: String,*/ endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void, festivalId: String){
        guard let url = URL(string: APIRetriever.urlGameList+"/"+festivalId) else {
            endofrequest(.failure(.badURL(APIRetriever.urlGameList+"/"+festivalId)))
            return
        }
        self.loadGamesFromAPI(url: url, endofrequest: endofrequest)
    }
    
    
        static func loadGamesFromAPI(url: URL, endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void){
            self.loadGamesFromJsonData(url: url, endofrequest: endofrequest)
        }

        private static func loadGamesFromJsonData(url: URL, endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decodedData : Decodable?
 
                   
                    decodedData = try? JSONDecoder().decode([ReservationData].self, from: data)
 
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    let tracksData : [ReservationData]

                    tracksData = (decodedResponse as! [ReservationData])
                    
                    guard let tracks = self.reservationDataToGames(data: tracksData) else{
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
    
    static func loadEditorsFromAPI(endofrequest: @escaping (Result<[EditorGameList],HttpRequestError>) -> Void, festivalId: String){
        guard let url = URL(string: APIRetriever.urlEditorList+"/"+festivalId) else {
            endofrequest(.failure(.badURL(APIRetriever.urlEditorList+"/"+festivalId)))
            return
        }
        self.loadEditorsFromJsonData(url: url, endofrequest: endofrequest)
    }
    

        private static func loadEditorsFromJsonData(url: URL, endofrequest: @escaping (Result<[EditorGameList],HttpRequestError>) -> Void){
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
    
    static func loadEditorGamesFromAPI(endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void, festivalId: String, editorId: String){
        guard let url = URL(string: APIRetriever.urlEditorGamesList+"/"+editorId+"/festival/"+festivalId) else {
            endofrequest(.failure(.badURL(APIRetriever.urlEditorGamesList+"/"+festivalId)))
            return
        }
        self.loadEditorGamesFromJsonData(url: url, endofrequest: endofrequest)
    }
    

        private static func loadEditorGamesFromJsonData(url: URL, endofrequest: @escaping (Result<[Game],HttpRequestError>) -> Void){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    print(String(decoding: data, as: UTF8.self))
                    let decodedData : Decodable?
                    
                    decodedData = try? JSONDecoder().decode([ReservedGameData].self, from: data)
                    
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    var tracksData : [ReservedGameData]

                    tracksData = (decodedResponse as! [ReservedGameData])
                    
                    guard let tracks = self.reservedGamesDataToGames(data: tracksData) else{
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
    
    static func loadZonesFromAPI(endofrequest: @escaping (Result<[ZoneGameList],HttpRequestError>) -> Void, festivalId : String){
        guard let url = URL(string: APIRetriever.urlZoneList+"/"+festivalId) else {
            endofrequest(.failure(.badURL(APIRetriever.urlZoneList+"/"+festivalId)))
            return
        }
        self.loadZonesFromJsonData(url: url, endofrequest: endofrequest)
    }
    

        private static func loadZonesFromJsonData(url: URL, endofrequest: @escaping (Result<[ZoneGameList],HttpRequestError>) -> Void){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decodedData : Decodable?
                    
                    decodedData = try? JSONDecoder().decode([ZoneGameListData].self, from: data)
                    
                    guard let decodedResponse = decodedData else {
                        DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                        return
                    }
                    var tracksData : [ZoneGameListData]

                    tracksData = (decodedResponse as! [ZoneGameListData])
                    
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
    
    static func reservationDataToGames(data: [ReservationData]) -> [Game]?{
        var games = [Game]()
        var reservedGames : [ReservedGameData]
            for tdata in data{
                reservedGames = tdata.reservedGame
                let optionalConvertedGames = reservedGamesDataToGames(data: reservedGames)
                if let convertedGames = optionalConvertedGames {
                    games.append(contentsOf: convertedGames)
                }
            }
            return games
        }
    
    static func reservedGamesDataToGames(data: [ReservedGameData]) -> [Game]?{
        var games = [Game]()
        var game : GameData
        var editor : Editor
        var zone : Zone
        for reservedGame in data {
            game = reservedGame.game
            editor = editorDataToEditor(data: game.gameEditor)
            zone = zoneDataToZone(data: reservedGame.zone)
            let track = Game(id: game.gameId, name: game.gameName, gameMinimumAge: game.gameMinimumAge, gameDuration: game.gameDuration, isPrototype: game.isPrototype, gameMinimumPlayers: game.gameMinimumPlayers, gameMaximumPlayers: game.gameMaximumPlayers, gameType: game.gameType.gameTypeName, gameEditor: editor, gameZone: zone, isAP: reservedGame.isAP, notice: game.gameNotice)
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
    
    
    static func editorDataToEditors(data: [EditorData]) -> [EditorGameList]?{
        var editors = [EditorGameList]()
        for tdata in data{
            let editor = EditorGameList(id: tdata.editorId, name: tdata.editorName, gameList: [Game]())
            editors.append(editor)
        }
        return editors
    }
    

    
    static func zoneDataToZones(data: [ZoneGameListData]) -> [ZoneGameList]?{
        var zones = [ZoneGameList]()
        
        for tdata in data{
            let zone = zoneDataToZone(data: tdata.zone)
            let zoneGL : ZoneGameList
            let optionalConvertedGames = reservedGamesDataToGames(data: tdata.gameList)
            if let convertedGames = optionalConvertedGames {
                zoneGL = ZoneGameList(zoneId: zone.zoneId, name: zone.name, gameList: convertedGames)
            }else{
                zoneGL = ZoneGameList(zoneId: zone.zoneId, name: zone.name, gameList: [Game]())
            }
            zones.append(zoneGL)
        }
        return zones
    }
    
    static func festivalDatatoFestival(data: [FestivalData]) -> Festival {
        let festival = Festival(festivalId: data[0].festivalId)
        return festival
    }
}
