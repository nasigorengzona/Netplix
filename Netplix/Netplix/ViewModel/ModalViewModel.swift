//
//  ModalViewModel.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import Foundation

class ModalViewModel : ObservableObject {
    @Published var movieTrailer : [VideoElement] = [VideoElement]()
    var movieTitle : String?
    
    func getTrailer() {
        APICaller.shared.getTrailer(with: movieTitle!) { result in
            switch result {
                case .success(let videoElement):
                    DispatchQueue.main.async {
                        self.movieTrailer = [videoElement]
                        print(videoElement.id)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
