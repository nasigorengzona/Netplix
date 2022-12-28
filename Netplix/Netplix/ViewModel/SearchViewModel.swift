//
//  SearchViewModel.swift
//  Netplix
//
//  Created by erlina ng on 28/12/22.
//

import Foundation
import Combine

class SearchViewModel : ObservableObject {
    @Published var allMovies : [Movie] = [Movie]()
    @Published var searchedMovies : [Movie] = [Movie]()
    @Published var searchTerm: String = "avengers"
    
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        getAllMovies()
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { term in
                self.searchMovie(movieTitle: term)
            }.store(in: &subscriptions)
    }
    
    private func getAllMovies() {
        APICaller.shared.getAllMovies() { result in
            switch result {
            case .success(let movies):
                self.allMovies.append(contentsOf: movies)
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
    private func searchMovie(movieTitle : String) {
        APICaller.shared.searchMovie(for: movieTitle) { result in
            switch result {
            case .success(let movies):
                self.searchedMovies.append(contentsOf: movies)
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
}
