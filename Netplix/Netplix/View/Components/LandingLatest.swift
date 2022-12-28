//
//  LandingLatest.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import SwiftUI

struct LandingLatest: View {
    var movieTitle = "After"
    var movieDesc = ""
    var moviePoster = ""
    @State var showModal = false
    
    var body: some View {
        VStack {
            if moviePoster == "" {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            } else {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w300/\(moviePoster)")) { image in
                    image.image?
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                }
            }
            Text(movieTitle)
                .fontWeight(.bold)
        }
        .frame(width: screenWidth * 0.4, height: screenHeight * 0.15)
        .padding(10)
        .background(Color.gray)
        .cornerRadius(20)
        .onTapGesture {
            showModal.toggle()
        }
        .sheet(isPresented: $showModal) {
            ModalView(movieTitle: self.movieTitle, movieDesc: self.movieDesc)
        }
    }
}

struct LandingLatest_Previews: PreviewProvider {
    static var previews: some View {
        LandingLatest()
    }
}
