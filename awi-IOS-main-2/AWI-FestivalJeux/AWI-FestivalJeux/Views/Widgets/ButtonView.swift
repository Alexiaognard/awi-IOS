//
//  ButtonView.swift
//  AWI-FestivalJeux
//
//  Created by user190796 on 3/23/21.
//

import SwiftUI

struct ButtonView: View {
    private let function : () -> ()
    private let label : String
    
    init(functionToCall: @escaping () ->(), label: String){
        self.function = functionToCall
        self.label = label
    }
    var body: some View {
        Button(action: self.function){
            HStack {
                Image(systemName: "arrow.clockwise.circle")
                Text(self.label)
                    .fontWeight(.semibold)
                }
            
            .padding(.all,7)
                .foregroundColor(.white)
                .background(Color.newGreen)
                .cornerRadius(40)
        }
        .padding(.all,5)
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(functionToCall: {return}, label: "Rafraîchir")
    }
}
