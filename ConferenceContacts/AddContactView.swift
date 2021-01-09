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
    
    @State var allContacts: [Contact]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                    Text("Tap to select picture")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                Spacer()
                
                TextField("Andrew Simpson", text: $name)
                    .font(.title)
                
                Spacer()
                
                Button(action: saveImage, label: {
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
            .sheet(isPresented: $showingImagePicker, onDismiss: displayImage) {
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
    
    func displayImage() {
        //display selected Image
    }
    
    func saveImage() {
        guard let finalImage = inputImage else {
            self.saveTitle = "Saving Failed!"
            self.saveMessage = "There is no image to process"
            self.showingSaveMessage = true
            return
        }

        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            self.saveTitle = "Saved Successfully!"
            self.saveMessage = "Filtered image has saved successfully"
            self.showingSaveMessage = true
        }
        
        imageSaver.errorHandler = {error in
            self.saveTitle = "Saving Failed!"
            self.saveMessage = error.localizedDescription
            self.showingSaveMessage = true
        }
        
        
        let imageName = "\(self.name).jpg"
        let imageUrl = ImageSaver().getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = finalImage.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: imageUrl, options: [.atomicWrite, .completeFileProtection])
                let newContact = Contact(name: self.name, image: imageUrl, imageName: imageName)
                allContacts.append(newContact)
                imageSaver.writeToDocumentFile(allContacts: allContacts)
            } catch let error {
                self.saveTitle = "Writing Image Failed!"
                self.saveMessage = error.localizedDescription
                self.showingSaveMessage = true
            }
        }
        
        //dismiss on completion
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(allContacts: [])
    }
}
