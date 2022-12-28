//
//  MovieGenre.swift
//  Netplix
//
//  Created by erlina ng on 28/12/22.
//

import SwiftUI

struct MovieGenre: View {
    @ObservedObject var movieGenreVM : MovieGenreViewModel = .init()
    var movieGenre = "Action"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(movieGenre)
                .font(.title2)
                .fontWeight(.bold)
            ScrollView(.horizontal) {
                if movieGenreVM.actionMovies.isEmpty {
                    ProgressView("Getting Action Movies")
                } else {
                    HStack(spacing: 20) {
                        ForEach(0..<(movieGenreVM.actionMovies.count)) {index in
                            MovieCell(movieTitle: movieGenreVM.actionMovies[index].original_title!, movieDesc: movieGenreVM.actionMovies[index].overview!, moviePoster: movieGenreVM.actionMovies[index].poster_path ?? "")
                        }
                    }
                }
            }
        }
        .padding(10)
    }
}

struct MovieGenre_Previews: PreviewProvider {
    static var previews: some View {
        MovieGenre()
    }
}
