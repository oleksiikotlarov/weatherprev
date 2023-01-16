//
//  WeatherTab.swift
//  WeatherLocator
//
//  Created by Алексей  on 12.11.2022.
//

import SwiftUI
import CoreLocation

struct WeatherTab: View {
    @Namespace var namespace
    @State var show = false
    
    @ObservedObject var viewmodel: WeatherViewModel
    @State var manager = CLLocationManager()
    
    @StateObject var managerDelegate = locationDelegate()
    var body: some View {
        ZStack {
            if !show {
                VStack() {
                    Text(viewmodel.name)
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame( maxWidth: .infinity, alignment: .leading)
                    
                    
                    Image(systemName: "\(viewmodel.img)")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: "img", in: namespace)
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 100, maxWidth: 180, minHeight: 100, maxHeight: 180, alignment: .leading)
                    
                    
                    HStack {
                        Spacer()
                        Text("\(viewmodel.temp.roundDouble())°C")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        
                            .matchedGeometryEffect(id: "temp", in: namespace)
                            .frame(alignment: .trailing)
                            .padding(5)
                        
                    }
                    
                    
                }
                .padding()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(
                    LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.9).matchedGeometryEffect(id: "color", in: namespace)
                )
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous).matchedGeometryEffect(id: "mask", in: namespace))
                .shadow(color: .black, radius: 10, x: 5, y: 5)
                .padding()
                
                
            } else {
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                    
                    
                    Image(systemName: "\(viewmodel.img)")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: "img", in: namespace)
                        .frame(minWidth: 170, maxWidth: 230, minHeight: 170, maxHeight: 230, alignment: .leading)
                        .padding(35)
                    // .padding(.vertical)
                    // .padding(.vertical)
                    
                    
                    HStack {
                        Spacer()
                        Text("\(viewmodel.temp.roundDouble())°C")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        
                            .matchedGeometryEffect(id: "temp", in: namespace)
                        
                        
                    }
                    
                    .padding(5)
                    .padding(.horizontal)
                    //Spacer()
                    
                    WeatherDetails()
                        .frame(alignment: .top)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .matchedGeometryEffect(id: "det", in: namespace)
                    
                    
                    
                    
                    Text(viewmodel.name)
                        .font(.largeTitle.weight(.bold))
                        .frame(alignment: .trailing)
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .padding()
                    
                    
                    HStack {
                        Spacer()
                        Text("tap to go back to menu")
                            .font(.body)
                            .frame(alignment: .center)
                            .opacity(0.65)
                        Spacer()
                    }
                    .padding()
                }
                
                .foregroundStyle(.white)
                .background(
                    LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.9).matchedGeometryEffect(id: "color", in: namespace)
                    
                )
                
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous).matchedGeometryEffect(id: "mask", in: namespace))
                .shadow(color: .black, radius: 10, x: 5, y: 5)
                
                
            }
        }
        .onAppear{
            viewmodel.refresh()
                
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.5)) {
                show.toggle()
            }
        }
        
        
    }
    
    
    
}

struct WeatherTab_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTab(viewmodel: WeatherViewModel(weatherService: WeatherService()))
    }
}
