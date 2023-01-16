//
//  ConfirmVIew.swift
//  weatherprev
//
//  Created by Алексей  on 19.12.2022.
//

import SwiftUI

struct ConfirmView: View {
    @ObservedObject var locations = Locations()
    @ObservedObject var locationService: LocationService
    //@Binding var item: String
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.75)
            VStack {
                TextField("Name", text: $name)
                    .padding()
                    .background(.red.opacity(0.5))
                    .mask(RoundedRectangle(cornerRadius: 30))
                HStack {
                    //Text(item)
                }
                .font(.title)
                .padding()
                
                Button("Add this location") {
                    self.name = name
                    let it = Location(name: self.name)
                    locations.items.append(it)
                    print(locations.items)
                    dismiss()
                    
                    
                }
                .padding()
                
                
            }
            .padding()
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
    }
    
    
    
}


class LocationAdjust: ObservableObject {
    @Published var items = [Location]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "SavedPlace")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "SavedPlace") {
            if let decodedItems = try? JSONDecoder().decode([Location].self, from: savedItems) {
                items = decodedItems
                print(items)
                return
            }
        }
        
        items = []
    }
}

struct Location: Codable, Identifiable {
    var id = UUID()
    let name: String
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView(locationService: LocationService.self.init())
    }
}
