//
//  ContactDetailView.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/10/21.
//

import SwiftUI

struct ContactDetailView: View {
    @State var contact: Contact
    
    var body: some View {
        VStack {
            if let contactImage = contact.image {
                Image(uiImage: contactImage)
                    .resizable()
                    .frame(width: 200, height: 200)
            } else {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(width: 200, height: 200)
            }
            
            Text(contact.name)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let myContact = Contact(name: "Midhet Sulemani", imageName: "\(UUID()).jpg")
        ContactDetailView(contact: myContact)
    }
}
