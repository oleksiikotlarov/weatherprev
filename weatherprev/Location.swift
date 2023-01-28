//
//  Location.swift
//  weatherprev
//
//  Created by Алексей  on 27.01.2023.
//

import Foundation

class Location: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    
}

@MainActor class Locations: ObservableObject {
    @Published private(set) var places: [Location]
    let saveKey = "SavedData"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Location].self, from: data) {
                places = decoded
                return
            }
        }

        places = []
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(places) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func add(_ place: Location) {
        places.append(place)
        save()
    }

    func toggle(_ place: Location) {
        objectWillChange.send()
        save()
    }
}
