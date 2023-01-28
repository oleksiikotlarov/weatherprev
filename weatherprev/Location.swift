//
//  Location.swift
//  weatherprev
//
//  Created by Алексей  on 27.01.2023.
//

import Foundation

struct Location: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    
}

class Locations: ObservableObject {
    @Published var items = [Location]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Save")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Save") {
            if let decodedItems = try? JSONDecoder().decode([Location].self, from: savedItems) {
                items = decodedItems
                
                return
            }
        }
        
        items = []
    }
}
