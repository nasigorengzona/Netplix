//
//  LatestView.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import SwiftUI

struct LatestView: View {
    @StateObject var latestVM : LatestViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Latest")
                .font(.title2)
                .fontWeight(.bold)
            ScrollView(.horizontal) {
                if latestVM.latestMovies.isEmpty {
                    ProgressView("Getting Latest Movie ~~")
                } else {
                    HStack(spacing: 20) {
                        ForEach(0..<5) {index in
                            LandingLatest(movieTitle: latestVM.latestMovies[index].original_title!, movieDesc: latestVM.latestMovies[index].overview!, moviePoster: latestVM.latestMovies[index].poster_path ?? "")
                        }
                    }
                }
            }
        }
        .padding(10)
    }
}

struct LatestView_Previews: PreviewProvider {
    static var previews: some View {
        LatestView()
    }
}
