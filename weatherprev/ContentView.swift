//
//  ContentView.swift
//  weatherprev
//
//  Created by Алексей  on 29.11.2022.
//

import SwiftUI


struct ContentView: View {
    @State var showFind = false
    
    var body: some View {
        NavigationView {
            VStack {
                WeatherTab(viewmodel: WeatherViewModel(weatherService: WeatherService()))
                
                LocationsListView()
                
                NavigationLink(destination: FindLocation(), isActive: $showFind ) {
                    HStack {
                        
                        HStack {
                            Spacer()
                            Text("Find location")
                            Image(systemName: "magnifyingglass.circle")
                            Spacer()
                        }
                        .padding()
                        .foregroundStyle(.white.opacity(0.87))
                        .font(.title3)
                        .background(LinearGradient(colors: [Color(red: 0.5, green: 0.2, blue: 0.7), Color(red: 0.3, green: 0.3, blue: 0.9)], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.65))
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(5)
                        
                    }
                    .shadow(color: .black, radius: 10, x: 5, y: 5)
                    
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.6)) {
                            showFind.toggle()
                            
                        }
                    }
                }
            }
            .background(
                LinearGradient(colors: [Color(red: 0.3, green: 0.0, blue: 0.5), Color(red: 0.6, green: 0.7, blue: 0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
