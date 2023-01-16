//
//  FindLocation.swift
//  weatherprev
//
//  Created by Алексей  on 29.11.2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct FindLocation: View {
    var body: some View {
        ZStack {
            MapView()
            
            Color.white.opacity(0.0).ignoresSafeArea()
            SearchView(locationService: LocationService.self.init())
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct MapView: View{
    
    @State var tracking : MapUserTrackingMode = .follow
    
    @State var manager = CLLocationManager()
    
    @StateObject var managerDelegate = locationDelegate()
    
    var body: some View {
        VStack{
            
            Map(coordinateRegion: $managerDelegate.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: managerDelegate.pins) { pin in
                MapPin(coordinate: pin.location.coordinate, tint: .red)
                
            }.edgesIgnoringSafeArea(.all)
        }
        .onAppear{
            manager.delegate = managerDelegate
            
            
        }
        
        

    }
}




struct FindLocation_Previews: PreviewProvider {
    static var previews: some View {
        FindLocation()
    }
}
