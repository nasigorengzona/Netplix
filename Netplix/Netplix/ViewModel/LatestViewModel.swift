//
//  LandingLatestViewModel.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import Foundation

class LatestViewModel : ObservableObject {
    @Published var latestMovies : [Movie] = [Movie]()
    
    init(){
        getLatestMovies()
    }
    
    private func getLatestMovies() {
        APICaller.shared.getLatestMovies { result in
            switch result {
            case .success(let movies):
                self.latestMovies.append(contentsOf: movies)
                print("Latest Movies : \(self.latestMovies.count)")
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
