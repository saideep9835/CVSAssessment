//
//  DetailView.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 12/4/24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = viewModel.imageUrl {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .padding()
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Text("Description:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(viewModel.parsedDescription)
                    .font(.body)
                    .padding(.horizontal)

                Text("Author:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(viewModel.parsedAuthor)
                    .font(.body)
                    .padding(.horizontal)

                Text("Published Date:")
                    .font(.headline)
                    .padding(.horizontal)
                Text(viewModel.formattedPublishedDate)
                    .font(.body)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Image Details")
    }
}

#Preview {
    let mockItem = Items(
        title: "Mock Title",
        link: "https://example.com",
        media: FlickerMedia(m: "https://live.staticflickr.com/example.jpg"),
        dateTaken: "2024-10-14T10:00:00Z",
        description: "<p>Mock Description</p><p>Extra Info</p>",
        published: "2024-10-14T14:30:00Z",
        author: "(\"Mock Author\")",
        authorId: "12345",
        tags: "mock, example"
    )
    DetailView(viewModel: DetailViewModel(item: mockItem))
}
