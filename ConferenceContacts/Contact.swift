//
//  Contact.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import Foundation

class Contact: Codable {
    
    var name: String
    var image: URL
    var imageName: String
    
    enum CodingKeys: CodingKey {
        case name, image, imageName
    }
    
    init(name: String, image: URL, imageName: String) {
        self.name = name
        self.image = image
        self.imageName = imageName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(URL.self, forKey: .image)
        imageName = try container.decode(String.self, forKey: .imageName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(imageName, forKey: .imageName)
    }
}
