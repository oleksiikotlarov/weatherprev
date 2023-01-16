//
//  WeatherDetails.swift
//  WeatherLocator
//
//  Created by Алексей  on 14.11.2022.
//

import SwiftUI

struct WeatherDetails: View {
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                VStack {
                    Text("monday")
                        .padding(10)
                    Image(systemName: "wind")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .padding(5)
                    Text("12.2°C")
                        .padding(10)
                }
                VStack {
                    Text("tuesday")
                        .padding(10)
                    Image(systemName: "cloud.rain.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .padding(5)
                    Text("10.6°C")
                        .padding(10)
                }
                VStack {
                    Text("wednesday")
                        .padding(10)
                    Image(systemName: "sun.max.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .padding(5)
                    Text("22.2°C")
                        .padding(10)
                }
                VStack {
                    Text("thursday")
                        .padding(10)
                    Image(systemName: "sun.max.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .padding(5)
                    Text("18.4°C")
                        .padding(10)
                }
                VStack {
                    Text("friday")
                        .padding(10)
                    Image(systemName: "cloud.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .padding(5)
                    Text("17.9°C")
                        .padding(10)
                }
            }
            
            .padding(.horizontal)
            
            
            
        }
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        /*.background(
            LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading)
                .opacity(0.1))
        */
        .background(.red.opacity(0.1))
        
        .font(.headline.weight(.bold))
        .foregroundStyle(.white)
        
        
        
        
    }
}

struct WeatherDetails_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetails()
    }
}
