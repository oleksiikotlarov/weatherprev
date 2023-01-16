//
//  EditView.swift
//  weatherprev
//
//  Created by Алексей  on 12.01.2023.
//

import SwiftUI

struct EditView: View {
    @State private var locations = ["Paris", "Madrid", "Milan"]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.7), Color(red: 0.8, green: 0.1, blue: 0.4)], startPoint: .bottomTrailing, endPoint: .topLeading).opacity(0.75)
            VStack {
                Image(systemName: "arrow.down")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding()
                    .onTapGesture {
                        dismiss()
                    }
                   
                List {
                    ForEach(locations, id: \.self) { location in
                        ZStack(alignment: .leading) {
                            
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(.white.opacity(0.3))
                            
                                .frame(height: 70)
                            
                            
                            HStack() {
                                Text("\(location)")
                            }
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                        }
                        
                        .listRowBackground(Color.white.opacity(0))
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(.vertical,5)
                        
                    }
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
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
