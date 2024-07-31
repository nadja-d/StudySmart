//
//  AddTerm.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI

struct AddTerm: View {
    
    @State var textFieldText: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .cornerRadius(10)
                
                Button(action: {
                    
                }, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add a term")
    }
}

struct AddTerm_Previews: PreviewProvider {
    static var previews: some View {
            AddTerm()
    }
}
