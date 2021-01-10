//
//  ContentView.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var allContacts = [Contact]()
    @State private var showAddContact = false
    
    var body: some View {
        NavigationView {
            List(allContacts) {contact in
                if let contactImage = contact.image {
                    Image(uiImage: contactImage)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
                
                Text(contact.name)
            }
            .navigationTitle("ConferenceContacts")
            .onAppear(perform: loadContacts)
            .navigationBarItems(trailing: Button(action: {
                self.showAddContact = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showAddContact, onDismiss: nil, content: {
                AddContactView(allContacts: $allContacts)
            })
        }
    }
    
    func loadContacts() {
        let filename = FileSaver.contactsPath
        do {
            let data = try Data(contentsOf: filename)
            allContacts = try JSONDecoder().decode([Contact].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
