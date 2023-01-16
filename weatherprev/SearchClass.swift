//
//  SearchClass.swift
//  weatherprev
//
//  Created by Алексей  on 19.12.2022.
//

import Foundation
import Combine
import MapKit

class LocationService: NSObject, ObservableObject {

    enum LocationStatus: Equatable {
        case idle
        case noResults
        case isSearching
        case error(String)
        case result
    }

    @Published var queryFragment: String = ""
    @Published private(set) var status: LocationStatus = .idle
    @Published private(set) var searchResults: [MKLocalSearchCompletion] = []

    private var queryCancellable: AnyCancellable?
    private let searchCompleter: MKLocalSearchCompleter!

    init(searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()) {
        self.searchCompleter = searchCompleter
        super.init()
        self.searchCompleter.delegate = self
        
        searchCompleter.delegate = self
        searchCompleter.region = MKCoordinateRegion(.world)
        searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
        queryCancellable = $queryFragment
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(20), scheduler: RunLoop.main, options: nil)
            .sink(receiveValue: { fragment in
                self.status = .isSearching
                if !fragment.isEmpty {
                    self.searchCompleter.queryFragment = fragment
                } else {
                    self.status = .idle
                    self.searchResults = []
                }
        })
    }
}

extension LocationService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        let searchResults = self.getCityList(results: completer.results)
        
        print(searchResults)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func getCityList(results: [MKLocalSearchCompletion]) -> [(city: String, country: String)]{
        
        var searchResults: [(city: String, country: String)] = []
        
        for result in results {
            
            let titleComponents = result.title.components(separatedBy: ", ")
            let subtitleComponents = result.subtitle.components(separatedBy: ", ")
            
            buildCityTypeA(titleComponents, subtitleComponents){place in
                
                if place.city != "" && place.country != ""{
                    
                    searchResults.append(place)
                }
            }
            
            buildCityTypeB(titleComponents, subtitleComponents){place in
                
                if place.city != "" && place.country != ""{
                    
                    searchResults.append(place)
                }
            }
        }
        
        
        
        return searchResults
    }
}

func buildCityTypeA(_ title: [String],_ subtitle: [String], _ completion: @escaping ((city: String, country: String)) -> Void){
    
    var city: String = ""
    var country: String = ""
    
    if title.count > 1 && subtitle.count >= 1 {
        
        city = title.first!
        country = subtitle.count == 1 && subtitle[0] != "" ? subtitle.first! : title.last!
    }
    
    completion((city, country))
}

func buildCityTypeB(_ title: [String],_ subtitle: [String], _ completion: @escaping ((city: String, country: String)) -> Void){
    
    var city: String = ""
    var country: String = ""
    
    if title.count >= 1 && subtitle.count == 1 {
        
        city = title.first!
        country = subtitle.last!
    }
    
    completion((city, country))

}
