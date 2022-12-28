//
//  LandingViewModel.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import Foundation

class LandingViewModel : ObservableObject {
    //var movies : [Movie] = [Movie]()
    @Published var highligtMovies : [Movie] = [Movie]()
    
    init(){
        getHighlightMovies()
    }
    
//    private func getAllMovies() {
//        APICaller.shared.getAllMovies(pagination: false) { result in
//            switch result {
//            case .success(let movies):
//                self.movies.append(contentsOf: movies)
//            case .failure(let error):
//                print(error.localizedDescription)
//                
//            }
//        }
//    }
    
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
    
}
