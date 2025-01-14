//
//  ContentView.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 10/14/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var flickrData = FlicrViewModel()
    @State private var searchText = ""
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    // MARK: - Body
    var body: some View {
        NavigationView{
            VStack {
                // MARK: - Title
                Text("Flicker App")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                // MARK: - Search Bar
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText, onCommit: {
                        Task { await flickrData.fetchData(for: searchText) }
                    })
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(.black,lineWidth: 1)
                )
                .padding()
                // MARK: - Loading Indicator
                if flickrData.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }
                ScrollView {
                    if flickrData.dataFromAPI?.items?.isEmpty ?? true && !flickrData.isLoading {
                        Text("No Results Found")
                            .padding()
                            .foregroundColor(.gray)
                    }else{
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(flickrData.dataFromAPI?.items ?? [], id: \.self) { data in
                                ImageGrid(item: data)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
            .onChange(of: searchText) { oldValue, newValue in
                Task { await flickrData.fetchData(for: newValue) }
            }
        }
    }
}


#Preview {
    ContentView()
}
