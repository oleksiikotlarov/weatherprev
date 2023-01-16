//
//  AddView.swift
//  weatherprev
//
//  Created by Алексей  on 14.12.2022.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var locations: Locations
    
    
    @State private var lati = 41.1
    @State private var long = 60.3
    @State private var name = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .padding()
                    .background(.red.opacity(0.5))
                    .mask(RoundedRectangle(cornerRadius: 30))
                
                TextField("Latitude of location", value: $lati, formatter: NumberFormatter.decimal )
                    .padding()
                    .background(.red.opacity(0.5))
                    .mask(RoundedRectangle(cornerRadius: 30))
                
                TextField("Longitude of location", value: $long, formatter: NumberFormatter.decimal)
                    .padding()
                    .background(.red.opacity(0.4))
                    .mask(RoundedRectangle(cornerRadius: 30))
                
                Button("Add location") {
                    
                    
                  /*
                    let newPlace = locations
                    newPlace.id = UUID()
                    newPlace.name = name
                    newPlace.lat = Double(lati)
                    newPlace.lon = Double(long)
                    
                    try? locations.add(<#Location#>)
                    */
                }
                .foregroundColor(.black)
                .padding()
                .background(.red.opacity(0.4))
                .mask(RoundedRectangle(cornerRadius: 30))
            }
            .padding()
            .font(.title)
            
        }
        
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.numberStyle = .decimal
        return formatter
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
