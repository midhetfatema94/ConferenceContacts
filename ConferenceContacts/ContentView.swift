//
//  ContentView.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                    Text("Tap to select picture")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                TextField("Andrew Simpson", text: $name)
                    .font(.title)
                
                Spacer()
            }
            .padding()
            .navigationTitle("ConferenceContacts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
