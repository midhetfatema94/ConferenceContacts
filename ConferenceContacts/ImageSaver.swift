//
//  ImageSaver.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import UIKit

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToDocumentFile(allContacts: [Contact]) {
        do {
            let filename = getContactsPath()
            let data = try JSONEncoder().encode(allContacts)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            successHandler?()
            print("Save finished!")
        } catch let error {
            errorHandler?(error)
            print("Unable to save data.")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func getContactsPath() -> URL {
        return getDocumentsDirectory().appendingPathComponent("contacts")
    }
}

