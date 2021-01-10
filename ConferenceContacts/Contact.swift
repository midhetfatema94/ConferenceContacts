//
//  Contact.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import Foundation
import UIKit

class Contact: Codable, Identifiable, Comparable {
    
    var id = UUID()
    var name: String
    var imageName: String
    var image: UIImage?
    
    enum CodingKeys: CodingKey {
        case name, imageName
    }
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imageName = try container.decode(String.self, forKey: .imageName)
        
        let fileUrl = FileSaver.documentsDirectory.appendingPathComponent(imageName)
        if let imageData = try? Data(contentsOf: fileUrl) {
            image = UIImage(data: imageData)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(imageName, forKey: .imageName)
    }
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name == rhs.name
    }
}
