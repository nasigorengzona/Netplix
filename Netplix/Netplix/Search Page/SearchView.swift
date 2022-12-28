//
//  SearchView.swift
//  Netplix
//
//  Created by erlina ng on 28/12/22.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchVM : SearchViewModel = .init()
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        
        if searchVM.allMovies.isEmpty {
            ProgressView("Searching movies")
        } else {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(searchVM.searchTerm != "" ? "Search" : "Recommendation")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 10)
                        
                        LazyVGrid(columns: columns) {

                            if searchVM.searchTerm == "" {
                                ForEach(0..<searchVM.allMovies.count, id: \.self) { i in
                                    MovieCell(movieTitle: searchVM.allMovies[i].original_title!, movieDesc: searchVM.allMovies[i].overview!, moviePoster: searchVM.allMovies[i].poster_path!)
                                }
                            } else {
                                ForEach(0..<searchVM.searchedMovies.count, id: \.self) { i in
                                    MovieCell(movieTitle: searchVM.searchedMovies[i].original_title!, movieDesc: searchVM.searchedMovies[i].overview!, moviePoster: searchVM.searchedMovies[i].poster_path ?? "")
                                }
                            }
                        }

                    }
                }
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
