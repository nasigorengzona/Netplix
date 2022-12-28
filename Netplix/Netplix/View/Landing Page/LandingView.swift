//
//  LandingPage.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject var searchVM : SearchViewModel
    @StateObject var landingVM : LandingViewModel = .init()
    
    @State var highlightSelected = 0
    @State var showSearchbar = false
    @State var movieTextField = ""
    
    let columns = [GridItem(), GridItem()]
    var highligtMovies = [Movie]()
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.black)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    var body: some View {
        if landingVM.highligtMovies.isEmpty {
            ProgressView("Fetching Data")
        }
        else {
            ScrollView {
                VStack(alignment: .leading) {
                    //MARK: Header
                    HStack {
                        if !showSearchbar {
                            Button {
                                
                            } label: {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                            }
                            
                            Spacer()
                            
                            Text("Netplix")
                                .font(.title)
                            
                            Spacer()
                        }
                        HStack {
                            if !showSearchbar {
                                Button {
                                    withAnimation{
                                        showSearchbar.toggle()
                                    }
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .imageScale(.large)
                                }
                            } else {
                                Image(systemName: "magnifyingglass")
                                    .imageScale(.large)
                                
                                TextField("Search Movie", text: $landingVM.seachQuery)
                                    
                                Button {
                                    withAnimation{
                                        showSearchbar.toggle()
                                        landingVM.seachQuery = ""
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.black)
                                        .imageScale(.large)
                                }
                                
                            }
                        }
                        .padding(showSearchbar ? 10 : 5)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(20)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    
                    if !showSearchbar {
                        //MARK: Highlight
                        TabView(selection: $highlightSelected.animation()) {
                            LandingHighlight(movieTitle: landingVM.highligtMovies[0].original_title!, movieDesc: landingVM.highligtMovies[0].overview!, moviePoster: landingVM.highligtMovies[0].poster_path!).tag(0)
                            LandingHighlight(movieTitle: landingVM.highligtMovies[1].original_title!, movieDesc: landingVM.highligtMovies[1].overview!, moviePoster: landingVM.highligtMovies[1].poster_path!).tag(1)
                            LandingHighlight(movieTitle: landingVM.highligtMovies[2].original_title!, movieDesc: landingVM.highligtMovies[2].overview!, moviePoster: landingVM.highligtMovies[2].poster_path!).tag(2)
                            LandingHighlight(movieTitle: landingVM.highligtMovies[3].original_title!, movieDesc: landingVM.highligtMovies[3].overview!, moviePoster: landingVM.highligtMovies[3].poster_path!).tag(3)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(height: screenHeight * 0.3)
                        
                        //MARK: Latest
                        LatestView()
                        
                        //MARK: Movie Genre
                        MovieGenre()
                    } else {
                        searchView()
                    }
                }
            }
            
        }
    }
    
    func searchView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(landingVM.seachQuery != "" ? "Search" : "Recommendation")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.leading, 10)

            LazyVGrid(columns: columns) {

                if landingVM.seachQuery == "" {
                    ForEach(0..<landingVM.allMovies.count, id: \.self) { i in
                        MovieCell(movieTitle: landingVM.allMovies[i].original_title!, movieDesc: landingVM.allMovies[i].overview!, moviePoster: landingVM.allMovies[i].poster_path!)
                    }
                } else {
                    ForEach(0..<landingVM.searchedMovies.count, id: \.self) { i in
                        MovieCell(movieTitle: landingVM.searchedMovies[i].original_title!, movieDesc: landingVM.searchedMovies[i].overview!, moviePoster: landingVM.searchedMovies[i].poster_path ?? "")
                    }
                }
            }
        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
