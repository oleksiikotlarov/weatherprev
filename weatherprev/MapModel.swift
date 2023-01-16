//
//  MapModel.swift
//  weatherprev
//
//  Created by Алексей  on 08.12.2022.
//

import Foundation
import SwiftUI
import MapKit

class locationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var pins : [Pin] = []
    
    @Published var location: CLLocation?
    @State var hasSetRegion = false
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.898150, longitude: -77.034340),
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )
    
    
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .authorizedWhenInUse{
            print("Authorized")
            manager.startUpdatingLocation()
        } else {
            print("not authorized")
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            
        
            self.location = location
            
            if hasSetRegion == false {
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                hasSetRegion = true
                
            }
            
        }
    }
}


struct Pin : Identifiable {
    var id = UUID().uuidString
    var location : CLLocation
}

