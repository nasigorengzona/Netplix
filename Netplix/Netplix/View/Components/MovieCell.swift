//
//  SearchMovie.swift
//  Netplix
//
//  Created by erlina ng on 28/12/22.
//

import SwiftUI

struct MovieCell: View {
    var movieTitle = "Unknown"
    var movieDesc = "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var moviePoster = ""
    @State var showModal = false
    
    var body: some View {
        VStack {
            Text(movieTitle)
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .minimumScaleFactor(0.01)
                .frame(height: 30)
            
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
        }
        .frame(width: screenWidth * 0.4, height: screenHeight * 0.3)
        .padding(8)
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

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell()
    }
}
