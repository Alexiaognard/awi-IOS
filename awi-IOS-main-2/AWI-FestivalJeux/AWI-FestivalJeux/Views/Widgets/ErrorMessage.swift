//
//  ErrorMessage.swift
//  AWI-FestivalJeux
//
//  Created by user190227 on 3/26/21.
//

import SwiftUI

struct ErrorMessage : View{
    let error :  Error
    var body: some View{
        VStack{
            Text("Erreur lors de la requête :")
                .foregroundColor(.red)
            if let error = error  as? HttpRequestError {
                Text("\(error.description)")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            else{
                Text("Erreur inconnue")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
        }
    }
}
