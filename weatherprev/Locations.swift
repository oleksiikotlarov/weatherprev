//
//  Locations.swift
//  weatherprev
//
//  Created by Алексей  on 08.12.2022.
//

import SwiftUI

class Locations: ObservableObject {
    @Published var items = [Location]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Dat")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Dat") {
            if let decodedItems = try? JSONDecoder().decode([Location].self, from: savedItems) {
                items = decodedItems
                print(items)
                return
            }
        }

        items = []
    }
}

/*struct Location: Codable, Identifiable {
    var id = UUID()
    let name: String
    
    
    
}


extension Bundle {
  func decode<T: Decodable>(_ file: String) -> T {
      guard let url = self.url(forResource: file, withExtension: nil) else {
          fatalError("Failed to locate \(file) in bundle")
      }
      
      guard let data = try? Data(contentsOf: url) else {
          fatalError("Failed to load \(file) in bundle")
      }
      
      let decoder = JSONDecoder()
      
      guard let loaded = try? decoder.decode(T.self, from: data) else {
          fatalError("Failed to decode \(file) in bundle")
      }
      
      return loaded
  }
}*/
