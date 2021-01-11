//
//  Contact.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/9/21.
//

import Foundation
import UIKit
import MapKit

class Contact: Codable, Identifiable, Comparable {
    
    var id = UUID()
    var name: String
    var imageName: String
    var image: UIImage?
    var locationDetails: LocationDetails?
    
    
    enum CodingKeys: CodingKey {
        case name, imageName, lat, long, locationTitle, locationSubtitle
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
        
        if let location = try? LocationDetails(from: decoder) {
            locationDetails = location
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(imageName, forKey: .imageName)
        
        if let personLocation = locationDetails {
            try personLocation.encode(to: encoder)
        }
    }
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name == rhs.name
    }
}

class LocationDetails: Codable {
    
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    
    enum CodingKeys: CodingKey {
        case lat, long, title, subtitle
    }
    
    init(lat: Double, long: Double, title: String, subtitle: String) {
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.title = title
        self.subtitle = subtitle
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let lat = try container.decode(Double.self, forKey: .lat)
        let long = try container.decode(Double.self, forKey: .long)
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.coordinate = coordinate
        
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(coordinate.latitude, forKey: .lat)
        try container.encode(coordinate.longitude, forKey: .long)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
    }
}
