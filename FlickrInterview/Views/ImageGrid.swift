//
//  ImageGrid.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//

import SwiftUI

struct ImageGrid: View {
    let item: Items
    var body: some View {
        if let imageUrl = item.media?.m, let url = URL(string: imageUrl) {
            NavigationLink(destination: DetailView(viewModel: DetailViewModel(item: item))) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            }
        } else {
            Color.gray
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
    }
}

#Preview {
    ImageGrid(item: Items(
        title: "Mock Title 1",
        link: "https://example.com/image1",
        media: FlickerMedia(m: "https://live.staticflickr.com/65535/54180499019_36ba01473a_m.jpg"),
        dateTaken: "2024-10-14T10:00:00Z",
        description: "Mock Description 1",
        published: "2024-10-14T14:30:00Z",
        author: "Mock Author 1",
        authorId: "12345",
        tags: "mock, sample"
    ))
}
