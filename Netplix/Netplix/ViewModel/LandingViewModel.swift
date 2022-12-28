//
//  LandingViewModel.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import Foundation
import Combine

class LandingViewModel : ObservableObject {
    @Published var allMovies : [Movie] = [Movie]()
    @Published var searchedMovies : [Movie] = [Movie]()
    @Published var highligtMovies : [Movie] = [Movie]()
    @Published var seachQuery: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    init(){
        getHighlightMovies()
        getAllMovies()
        
        $seachQuery
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { term in
                self.searchMovie(movieTitle: term)
            }.store(in: &subscriptions)
    }
    
    private func getHighlightMovies() {
        APICaller.shared.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                self.highligtMovies.append(contentsOf: movies)
                print("Highlight Movies : \(self.highligtMovies.count)")
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
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
                self.searchedMovies = movies
                //self.searchedMovies.append(contentsOf: movies)
                print("Searched Movies : \(movies.count)")
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
}
