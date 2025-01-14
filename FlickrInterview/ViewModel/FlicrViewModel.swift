//
//  FlicrViewModel.swift
//  FlickrInterview
//
//  Created by Saideep Reddy Talusani on 1/14/25.
//

import Foundation

class FlicrViewModel: ObservableObject{
    
    // MARK: - Published Properties
    @Published var dataFromAPI: FlicrModel?
    @Published var isLoading: Bool = false
    
    // MARK: - Private Properties
    private let apiManager: ApiProtocol
    
    // MARK: - Initializer
    // Initializes the ViewModel with a custom or default API manager.
    // - Parameter apiManager: The API manager to use for network requests.
    init(apiManager: ApiProtocol = APIManager.shared) {
            self.apiManager = apiManager
            fetchInitialData()
    }
    
    // MARK: - Data Fetching Methods
    // Fetches initial data with a default search term.
    func fetchInitialData() {
            Task {
                await fetchData(for: "nature") // Default search term
            }
        }
    
    // Fetches data for the given search term from the API.
    // - Parameter text: The search term entered by the user.
    func fetchData(for text: String) async{
        guard !text.isEmpty else {
            self.dataFromAPI = nil
            return
        }
        DispatchQueue.main.async {
                self.isLoading = true  // Start loading
            }
        guard let url = URL(string: Constants.apiUrl.rawValue + text) else {
            DispatchQueue.main.async {
                self.isLoading = false  
            }
            self.dataFromAPI = nil
            return
        }
        do{
            let data: FlicrModel = try await apiManager.getData(url: url)
            DispatchQueue.main.async{
                self.dataFromAPI = data
                self.isLoading = false
            }
        }catch{
            DispatchQueue.main.async {
                self.isLoading = false  // Stop loading on error
            }
            print(error.localizedDescription)
        }
    }
    
}
