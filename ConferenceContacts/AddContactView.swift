//
//  AddContactView.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import SwiftUI

struct AddContactView: View {
    @State private var name: String = ""
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    
    @State private var showingSaveMessage = false
    @State private var saveMessage = ""
    @State private var saveTitle = ""
    
    @Binding var allContacts: [Contact]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if let image = inputImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select picture")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                Spacer()
                
                TextField("Andrew Simpson", text: $name)
                    .font(.title)
                
                Spacer()
                
                Button(action: saveData, label: {
                    Text("Save Data")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                })
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .padding()
            .navigationTitle("ConferenceContacts")
            .sheet(isPresented: $showingImagePicker, onDismiss: nil) {
                ImagePicker(image: self.$inputImage)
            }
            .alert(isPresented: $showingSaveMessage, content: {
                Alert(title: Text(self.saveTitle),
                      message: Text(self.saveMessage),
                      dismissButton: .default(Text("Okay"))
                )
            })
        }
    }
    
    func saveData() {
        guard let finalImage = inputImage else {
            self.saveTitle = "Saving Failed!"
            self.saveMessage = "There is no image to process"
            self.showingSaveMessage = true
            return
        }

        let imageSaver = FileSaver()
        
        imageSaver.successHandler = {
            presentationMode.wrappedValue.dismiss()
        }
        
        imageSaver.errorHandler = {error in
            self.saveTitle = "Saving Failed!"
            self.saveMessage = error.localizedDescription
            self.showingSaveMessage = true
        }
        
        if let jpegData = finalImage.jpegData(compressionQuality: 0.8) {
            
            let imageId = UUID()
            let imageName = "\(imageId).jpg"
            let imageUrl = FileSaver.documentsDirectory.appendingPathComponent(imageName)
            
            let newContact = Contact(name: self.name, imageName: imageName)
            newContact.image = finalImage
            allContacts.append(newContact)
            allContacts = allContacts.sorted()
            imageSaver.writeToDocumentFile(allContacts: allContacts, imageData: jpegData, imageUrl: imageUrl)
        } else {
            self.saveTitle = "Writing Image Failed!"
            self.saveMessage = "Could not read image data"
            self.showingSaveMessage = true
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(allContacts: .constant([]))
    }
}
