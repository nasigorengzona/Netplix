//
//  ModalPage.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import SwiftUI
import WebKit

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var modalVM : ModalViewModel = ModalViewModel()
    
    var movieTitle = "Unknown"
    var movieDesc = "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    
    var body: some View {
        if modalVM.movieTrailer.isEmpty {
            ProgressView("We're preparing your movie info. Please Wait.")
                .onAppear{
                    modalVM.movieTitle = self.movieTitle
                    modalVM.getTrailer()
                }
        } else {
            VStack {
                HStack{
                    Spacer()
                    Button {
                      presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding(10)
                    }
                }
                
                VideoView(videoId: modalVM.movieTrailer[0].id)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(movieTitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                    Text(movieDesc)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 100))
                        .minimumScaleFactor(0.01)
                        .padding(.horizontal, 20)
                    
                    LatestView()
                        .padding(.horizontal, 10)
                }
            }
        }
    }
}

struct ModalPage_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
