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
    @Environment(\.dismiss) var dismiss
    @State private var isShowingSheet = false
    
    var body: some View {
        ZStack {
            MapView()
            
            Color.white.opacity(0.0).ignoresSafeArea()
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "arrow.left")
                        Button("Back"){
                            dismiss()
                        }
                        
                        .padding(.horizontal,10)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.7))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(10)
                    Spacer()
                }
               
                Spacer()
                
                HStack {
                    Spacer()
                    Spacer()
                    HStack {
                        Text("Search for a location")
                            .font(.headline)
                        
                        Image(systemName: "magnifyingglass.circle")
                        
                    }
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(5)
                    
                }
                .padding()
                .background(LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.7))
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding(10)
                .onTapGesture {
                    isShowingSheet.toggle()
                }
                .sheet(isPresented: $isShowingSheet) {
                    EditView()
                }
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationTitle("")
        }
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
            .preferredColorScheme(.dark)
    }
}
