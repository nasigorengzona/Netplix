//
//  LandingHighlight.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import SwiftUI

struct LandingHighlight: View {
    var movieTitle = "Unknown"
    var movieDesc = "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var moviePoster = ""
    @State var showModal = false
    
    var body: some View {
        HStack {
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
            
            VStack(alignment: .leading) {
                Text(movieTitle)
                    .fontWeight(.bold)
                Text(movieDesc)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
            }
        }
        .padding(10)
        .frame(width: screenWidth * 0.9 ,height: screenHeight * 0.2)
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

struct LandingHighlight_Previews: PreviewProvider {
    static var previews: some View {
        LandingHighlight()
    }
}
