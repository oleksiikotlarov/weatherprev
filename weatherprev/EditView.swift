//
//  EditView.swift
//  weatherprev
//
//  Created by Алексей  on 12.01.2023.
//

import SwiftUI
import MapKit

struct EditView: View {
    @StateObject var locations = Locations()
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    @State private var showAddButton = false
    @FocusState var isFocused : Bool
    var body: some View {
        ZStack {
            NavigationView {
                
                VStack(alignment: .leading) {
                    
                    
                    HStack {
                        Text("Edit your locations")
                            .padding()
                        
                            .font(.title)
                            .opacity(0.9)
                        Spacer()
                        Button("Done") {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5)) {
                                dismiss()
                            }
                        }
                        
                        .padding()
                        .background(.white.opacity(0.3))
                        .mask(RoundedRectangle(cornerRadius: 20))
                        .padding(5)
                    }
                    .padding(.vertical)
                    VStack {
                        TextField("Search for a location", text: $text)
                            .padding(.vertical,5)
                            .focused($isFocused)
                            
                        if text.isEmpty {
                            
                        } else {
                            Divider()
                            Button("Add"){
                                isFocused = false
                                let textCorrect = text.replacingOccurrences(of: " ", with: "")
                                let encoder = JSONEncoder()
                                let item = Location(id: UUID(), name: textCorrect)
                                
                                if let data = try? encoder.encode(item) {
                                    UserDefaults.standard.set(data, forKey: "Save")
                                }
                                
                                locations.items.append(item)
                                
                                
                                dismiss()
                            }
                        }
                    }
                    .padding()
                    .background(.white.opacity(0.2))
                    .mask(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical,10)
                    .font(.headline)
                    List {
                        ForEach(locations.items) { location in
                            ZStack(alignment: .leading) {
                                
                                RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .fill(.white.opacity(0.3))
                                
                                    .frame(height: 70)
                                
                                
                                HStack() {
                                    Text("\(location.name)")
                                }
                                .font(.body)
                                .foregroundColor(.white)
                                .padding()
                            }
                            
                            .listRowBackground(Color.white.opacity(0))
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.vertical,5)
                            
                        }
                        .onDelete(perform: removeItems)
                    }
                    
                    .onAppear {
                        UITableView.appearance().backgroundColor = .clear
                        UITableViewCell.appearance().backgroundColor = .clear
                    }
                    .listStyle(.plain)
                    .font(.title)
                    .padding(.vertical,20)
                    
                   
                }
                .padding(3)
                .background(.black.opacity(0.2))
                .background(LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.9).saturation(0.9))
                .foregroundColor(.white)
                .navigationBarHidden(true)
                .ignoresSafeArea()
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        locations.items.remove(atOffsets: offsets)
    }
}



struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
            .preferredColorScheme(.dark)
    }
}
