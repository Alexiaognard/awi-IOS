//
//  Editor.swift
//  AWI-FestivalJeux
//
//  Created by Alexia Ognard on 09/03/2021.
//

import Foundation


class Editor : Identifiable, Codable {
    var editorId : String
    var editorName : String
    
    init(id: String, name:String){
        self.editorId = id
        self.editorName = name
    }
}
