//
//  FileSaver.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import UIKit

class FileSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToDocumentFile(allContacts: [Contact], imageData: Data, imageUrl: URL) {
        do {
            let filename = FileSaver.contactsPath
            let data = try JSONEncoder().encode(allContacts)
            
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            try imageData.write(to: imageUrl, options: [.atomicWrite, .completeFileProtection])
            
            successHandler?()
            print("Save finished!")
        } catch let error {
            errorHandler?(error)
            print("Unable to save data.")
        }
    }
    
    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    static var contactsPath: URL {
        return FileSaver.documentsDirectory.appendingPathComponent("contacts")
    }
}

