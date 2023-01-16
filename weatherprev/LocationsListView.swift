//
//  LocationsListView.swift
//  WeatherLocator
//
//  Created by Алексей  on 25.11.2022.
//

import SwiftUI
import MapKit

struct LocationsListView: View {
    
    @StateObject var places = PlacesWeather()
    @StateObject var locats = Locations()
    
    @State var weath = WeatherManager()
    
    var body: some View {
        
        VStack {
            List {
                ForEach(places.items) { weather in
                    HStack() {
                        Text(weather.name)
                            .frame(height: 50)
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: weather.icon)
                            //.renderingMode(.original)
                                .padding(.horizontal)
                            Text("\(weather.temp.roundDouble())°C")
                                .scaledToFill()
                                .frame(width: 80, height: 20)
                        }
                        
                        .padding(.horizontal)
                        
                    }
                    .font(.title3)
                    .padding()
                    .listRowBackground(Color.white.opacity(0))
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0 ))
                    .foregroundColor(.black)
                    .background(.white.opacity(0.2))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    .padding(.vertical, 5)
                }
                
                .onDelete(perform: removeItems)
                
            }
            
            .listStyle(.plain)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
                
            }
            .padding(7)
        }
        .onAppear {
            weath.clear()
            weath.refresh()
        }
    }
    
    
    func removeItems(at offsets: IndexSet) {
        places.items.remove(atOffsets: offsets)
    }
}


struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
