//
//  MovieGenreViewModel.swift
//  Netplix
//
//  Created by erlina ng on 28/12/22.
//

import Foundation

class MovieGenreViewModel : ObservableObject {
    @Published var actionMovies : [Movie] = [Movie]()
    
    init(){
        getActionMovie()
    }
    
    private func getActionMovie() {
        APICaller.shared.actionMovie { result in
            switch result {
            case .success(let movies):
                self.actionMovies.append(contentsOf: movies)
                print("Movies Genre : \(self.actionMovies.count)")
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
