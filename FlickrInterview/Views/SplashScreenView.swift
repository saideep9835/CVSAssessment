//
//  SplashScreenView.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false // Tracks if splash screen should transition

    var body: some View {
        if isActive {
            ContentView() // Your main content view
        } else {
            VStack {
                Text("Welcome to Flickr App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
            .onAppear {
                // Show the splash screen for 1 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}


#Preview {
    SplashScreenView()
}
