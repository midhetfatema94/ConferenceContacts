//
//  MapView.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/10/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var placeTitle: String
    @Binding var placeSubtitle: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        //Binding the delegate of this view to the updates from the coordinator
        mapView.delegate = context.coordinator

        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if view.annotations.count > 1 {
            view.removeAnnotations(view.annotations)
        }
        let annotation = MKPointAnnotation()
        annotation.title = placeTitle
        annotation.subtitle = placeSubtitle
        annotation.coordinate = centerCoordinate
        view.addAnnotations([annotation])
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(self)
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), placeTitle: .constant(MKPointAnnotation.example.title ?? ""), placeSubtitle: .constant(MKPointAnnotation.example.subtitle ?? ""))
    }
}
