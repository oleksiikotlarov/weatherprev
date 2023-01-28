//
//  SearchView.swift
//  WeatherLocator
//
//  Created by Алексей  on 16.11.2022.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @ObservedObject var locationService: LocationService
    @State private var isShowingSheet = false
    @Namespace var namespace
    @State var item = "A"
    @State var show = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ZStack {
            if show == false {
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                                .padding(.horizontal,10)
                            
                        }
                        .padding()
                        .background(LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.7))
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(10)
                        .onTapGesture {
                            dismiss()
                        }
                        Spacer()
                        HStack {
                            
                            Text("Edit")
                                .padding(.horizontal,10)
                            Image(systemName: "pencil")
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
                    .foregroundColor(.white)
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Spacer()
                        HStack {
                            Text("Search for a location")
                                .font(.headline)
                            
                            Image(systemName: "magnifyingglass.circle")
                            
                        }
                        .matchedGeometryEffect(id: "pic", in: namespace)
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(5)
                        
                    }
                    .padding()
                    .background(LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.7).matchedGeometryEffect(id: "background", in: namespace))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(10)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.9, blendDuration: 1)) {
                            show.toggle()
                        }
                    }
                    
                    
                    
                }
                
                
                
            } else {
                VStack {
                    VStack {
                        HStack {
                            HStack {
                                TextField("Search for a location", text: $locationService.queryFragment)
                                
                                    .font(.title3)
                                    .keyboardType(.default)
                                
                                
                                
                                
                                Spacer()
                                
                            }
                            .matchedGeometryEffect(id: "pic", in: namespace)
                            
                            .padding(5)
                            
                            Spacer()
                            Spacer()
                        }
                        .padding()
                        .background(.white.opacity(0.3))
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        
                        
                        List {
                            ForEach(locationService.searchResults, id: \.self) { completionResult in
                                ItemCell(item: completionResult.title)
                                
                                
                                
                                
                            }
                            
                            .listRowBackground(Color.white.opacity(0))
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(7)
                        }
                        
                        .onAppear {
                            UITableView.appearance().backgroundColor = .clear
                            UITableViewCell.appearance().backgroundColor = .clear
                        }
                        .listStyle(.plain)
                        
                        
                        
                        
                        HStack {
                            Spacer()
                            Text("tap to go back to menu")
                                .font(.body)
                            
                                .frame(alignment: .center)
                                .shadow(color: .white, radius: 20, x: 30, y: 30)
                            Spacer()
                        }
                        
                        .padding(20)
                        .background(.red.opacity(0.2))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.8, dampingFraction: 0.9, blendDuration: 1).speed(1.5)) {
                                
                                dismiss()
                            }
                        }
                        
                    }
                    .background(LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.9).matchedGeometryEffect(id: "background", in: namespace))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .frame(alignment: .top)
                    
                }
                
                
                .padding(10)
                
            }
        }
        
        
        
    }
    
}

struct ItemCell: View {
    @ObservedObject var locations = Locations()
    @Environment(\.dismiss) var dismiss
    var item: String
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.white.opacity(0.3))
            
                .frame(height: 70)
            
            
            HStack() {
                Text("\(item)")
            }.font(.body)
                .foregroundColor(.white)
                .padding()
        }
        
        .onTapGesture {
            print("Tapped list, item:\(item)")
            let it = Location(name: item)
            locations.items.append(it)
            print(locations.items)
            dismiss()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(locationService: LocationService.self.init())
    }
}
